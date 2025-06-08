import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/tree_repository.dart';
import '../../models/tree_model.dart';
import '../../widgets/tree_profile_card.dart';
import '../../widgets/tree_filter_widget.dart';
import 'map_controller.dart';
import '../maturity/upcoming_maturity_page.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final TreeRepository _treeRepository = TreeRepository();

  final Set<Marker> _markers = {};
  final Set<String> _favoriteIds = {};
  final List<Tree> _favoriteTrees = [];
  List<Tree> _allTrees = [];
  List<Tree> _filteredTrees = [];

  // Filter criteria
  int _minHeight = 1;
  int _maxHeight = 50;
  int _minGirth = 1;
  int _maxGirth = 200;
  int _minAge = 1;
  int _maxAge = 1500;
  bool _filtersActive = false;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(47.614800206326926, -122.35563209083134),
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to wait for the first frame to be drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMap();
    });
  }

  Future<void> _initializeMap() async {
    await _mapController.initialize();
    await _loadTreeMarkers();

    final status = await _mapController.requestLocationPermission();

    if (status.isGranted) {
      _mapController.startProximityMonitoring();
    } else if (status.isPermanentlyDenied) {
      _showPermissionDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enable background location to get proximity alerts.'),
        ),
      );
    }
  }

  Future<void> _showPermissionDialog() async {
    // Ensure the widget is still in the tree and can show dialogs
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Background location is permanently denied. Please open settings to enable it for this app.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings(); // This opens the app's settings page
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _loadTreeMarkers() async {
    final trees = await _treeRepository.getTrees();
    _allTrees = trees;
    _filteredTrees = trees; // Initially show all trees
    _updateMarkers();
  }

  void _updateMarkers() {
    final treesToShow = _filtersActive ? _filteredTrees : _allTrees;
    
    final newMarkers = treesToShow.map((tree) {
      final isFav = _favoriteIds.contains(tree.id);
      
      // Calculate compatibility for marker color
      final compatibility = tree.calculateCompatibility(
        preferredZodiac: 'Leo',
        preferredBloodType: 'O',
        preferredMinIQ: 100,
        preferredMaxAge: 1000,
        preferMature: true,
      );
      
      // Choose marker color based on compatibility
      double hue;
      if (isFav) {
        hue = BitmapDescriptor.hueRed; // Favorites are always red
      } else if (compatibility >= 80) {
        hue = BitmapDescriptor.hueGreen; // High compatibility
      } else if (compatibility >= 60) {
        hue = BitmapDescriptor.hueOrange; // Medium compatibility
      } else {
        hue = BitmapDescriptor.hueBlue; // Low compatibility
      }
      
      return Marker(
        markerId: MarkerId(tree.id),
        position: LatLng(tree.latitude, tree.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(hue),
        infoWindow: InfoWindow(
          title: '${tree.name} - $compatibility% Match',
          snippet: 'Tap for full profile • ${tree.isMature ? "Mature 🍎" : "Growing 🌱"} • ${tree.rings} rings',
          onTap: () => _showTreeOptions(tree),
        ),
      );
    }).toSet();

    if (mounted) {
      setState(() {
        _markers
          ..clear()
          ..addAll(newMarkers);
      });
    }
  }

  void _applyFilters(int minHeight, int maxHeight, int minGirth, int maxGirth, int minAge, int maxAge) {
    setState(() {
      _minHeight = minHeight;
      _maxHeight = maxHeight;
      _minGirth = minGirth;
      _maxGirth = maxGirth;
      _minAge = minAge;
      _maxAge = maxAge;
      _filtersActive = true;
      
      _filteredTrees = _allTrees.where((tree) {
        return tree.length >= minHeight &&
               tree.length <= maxHeight &&
               tree.girth >= minGirth &&
               tree.girth <= maxGirth &&
               tree.age >= minAge &&
               tree.age <= maxAge;
      }).toList();
    });
    _updateMarkers();
  }

  void _clearFilters() {
    setState(() {
      _filtersActive = false;
      _filteredTrees = _allTrees;
    });
    _updateMarkers();
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TreeFilterWidget(
        onFiltersChanged: _applyFilters,
        onClearFilters: _clearFilters,
      ),
    );
  }

  void _toggleFavorite(Tree tree) {
    if (!mounted) return;
    setState(() {
      if (_favoriteIds.remove(tree.id)) {
        _favoriteTrees.removeWhere((t) => t.id == tree.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Removed "${tree.name}" from favorites')),
        );
      } else {
        _favoriteIds.add(tree.id);
        _favoriteTrees.add(tree);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added "${tree.name}" to favorites')),
        );
      }
      _updateMarkers();
    });
  }

  void _showTreeOptions(Tree tree) {
    final isFav = _favoriteIds.contains(tree.id);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: TreeProfileCard(
          tree: tree,
          isFavorite: isFav,
          onFavorite: () {
            Navigator.of(context).pop();
            _toggleFavorite(tree);
          },
          onPass: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.stopProximityMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final center = _markers.isNotEmpty
        ? _markers.first.position
        : _initialCameraPosition.target;

    return Scaffold(
      appBar: AppBar(
        title: Text(_filtersActive 
          ? 'Trees (${_filteredTrees.length} filtered)' 
          : 'Trees Near You'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: _filtersActive ? Colors.orange : null,
            ),
            tooltip: 'Filter Trees',
            onPressed: _showFilterModal,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'View Favorites',
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/favorites',
                arguments: _favoriteTrees,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.timeline),
            tooltip: 'Soon to Mature',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => UpcomingMaturityPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: center, zoom: 14),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Compatibility Legend
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Compatibility',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildLegendItem('🔴', 'Favorites', Colors.red),
                  _buildLegendItem('🟢', '80%+ Match', Colors.green),
                  _buildLegendItem('🟠', '60%+ Match', Colors.orange),
                  _buildLegendItem('🔵', 'Low Match', Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String emoji, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}