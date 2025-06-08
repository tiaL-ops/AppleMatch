import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/tree_repository.dart';
import '../../models/tree_model.dart';
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

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(47.614800206326926, -122.35563209083134),
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _mapController.initialize();
    await _loadTreeMarkers();

    final granted = await _mapController.requestLocationPermission();
    if (granted) {
      _mapController.startProximityMonitoring();
    } else {
      final status = await Permission.locationAlways.status;
      if (status.isPermanentlyDenied) {
        _showPermissionDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enable background location to get proximity alerts.'),
          ),
        );
      }
    }
  }

  Future<void> _showPermissionDialog() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Background location is permanently denied. Please open settings to enable it.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
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
    final newMarkers = trees.map((tree) {
      final isFav = _favoriteIds.contains(tree.id);
      return Marker(
        markerId: MarkerId(tree.id),
        position: LatLng(tree.latitude, tree.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          isFav ? BitmapDescriptor.hueRed : BitmapDescriptor.hueGreen,
        ),
        infoWindow: InfoWindow(
          title: tree.name,
          snippet: 'Planted: ${tree.plantedDate}',
          onTap: () => _showTreeOptions(tree),
        ),
      );
    }).toSet();

    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });
  }

  void _toggleFavorite(Tree tree) {
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
      _loadTreeMarkers();
    });
  }

  void _showTreeOptions(Tree tree) {
    final isFav = _favoriteIds.contains(tree.id);

    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tree.name, style: Theme.of(context).textTheme.headlineSmall),
            Text('Planted: ${tree.plantedDate}'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              label: Text(
                isFav ? 'Remove from Favorites' : 'Add to Favorites',
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _toggleFavorite(tree);
              },
            ),
          ],
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
        title: const Text('Trees Near You'),
        actions: [
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
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: center, zoom: 14),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
