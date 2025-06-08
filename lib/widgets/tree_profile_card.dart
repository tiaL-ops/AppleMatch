import 'package:flutter/material.dart';
import '../models/tree_model.dart';
import '../features/matches/macthes_screen.dart';
class TreeProfileCard extends StatelessWidget {
  final Tree tree;
  final VoidCallback? onFavorite;
  final VoidCallback? onPass;
  final bool isFavorite;

  const TreeProfileCard({
    Key? key,
    required this.tree,
    this.onFavorite,
    this.onPass,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Calculate compatibility with fun default preferences
    final compatibility = tree.calculateCompatibility(
      preferredZodiac: 'Leo', // Daddy Apple loves confidence
      preferredBloodType: 'O', // Universal compatibility 
      preferredMinIQ: 100, // Smart trees only
      preferredMaxAge: 1000, // Not too old
      preferMature: true, // Mature trees are ready for harvest
    );
    
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75, // More responsive height
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Tree Image - Fixed height
                Container(
                  height: MediaQuery.of(context).size.height * 0.4, // Fixed portion of screen
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _getTreeColor(tree.name),
                        _getTreeColor(tree.name).withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Tree Emoji/Icon based on type
                            Text(
                              _getTreeEmoji(tree.name),
                              style: const TextStyle(fontSize: 80), // Slightly smaller
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                tree.name,
                                style: const TextStyle(
                                  fontSize: 20, // Slightly smaller
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Age indicator
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '${tree.age} days old',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 12, // Smaller text
                            ),
                          ),
                        ),
                      ),
                      // Compatibility Score
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getCompatibilityColor(compatibility),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getCompatibilityIcon(compatibility),
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$compatibility% Match',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Tree Info - Flexible content
                Padding(
                  padding: const EdgeInsets.all(16), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and basic info
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tree.name,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Planted ${_formatDate(tree.plantedDate)}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Maturity status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tree.isMature 
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              tree.isMature ? 'Mature 🍎' : '${tree.daysUntilMature} days to go',
                              style: TextStyle(
                                color: tree.isMature ? Colors.green[700] : Colors.orange[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Personality traits as rounded boxes
                      Wrap(
                        spacing: 8, // Space between boxes horizontally
                        runSpacing: 8, // Space between rows
                        children: [
                          _buildTraitBox('🧠 IQ ${tree.iq}', theme, Colors.purple[100]!),
                          _buildTraitBox('♈ ${tree.zodiac}', theme, Colors.orange[100]!),
                          _buildTraitBox('🩸 ${tree.bloodtype}', theme, Colors.red[100]!),
                          _buildTraitBox('📏 ${tree.length} ft tall', theme, Colors.blue[100]!),
                          _buildTraitBox('⭕ ${tree.girth}" girth', theme, Colors.green[100]!),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            Icons.close,
                            Colors.grey,
                            onPass ?? () {},
                          ),
                          _buildActionButton(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            theme.colorScheme.primary,
  () {
    Navigator.pushNamed(context, '/matches');
  },
                           
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20), // Bottom padding for scroll
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTraitBox(String label, ThemeData theme, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14, // Slightly smaller
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55, // Slightly smaller
        height: 55,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(
          icon,
          color: color,
          size: 26, // Slightly smaller
        ),
      ),
    );
  }

  String _getTreeEmoji(String treeType) {
    switch (treeType.toLowerCase()) {
      case 'pine':
        return '🌲';
      case 'oak':
        return '🌳';
      case 'birch':
        return '🌿';
      case 'cedar':
        return '🌲';
      case 'aspen':
        return '🍃';
      case 'fir':
        return '🌲';
      case 'elm':
        return '🌳';
      default:
        return '🌳';
    }
  }

  Color _getTreeColor(String treeType) {
    switch (treeType.toLowerCase()) {
      case 'pine':
        return const Color(0xFF2E7D32);
      case 'oak':
        return const Color(0xFF5D4037);
      case 'birch':
        return const Color(0xFF81C784);
      case 'cedar':
        return const Color(0xFF1B5E20);
      case 'aspen':
        return const Color(0xFF66BB6A);
      case 'fir':
        return const Color(0xFF388E3C);
      case 'elm':
        return const Color(0xFF795548);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month]} ${date.day}, ${date.year}';
  }

  Color _getCompatibilityColor(int compatibility) {
    if (compatibility >= 80) return Colors.green;
    if (compatibility >= 60) return Colors.orange;
    return Colors.red;
  }

  IconData _getCompatibilityIcon(int compatibility) {
    if (compatibility >= 80) return Icons.favorite;
    if (compatibility >= 60) return Icons.thumb_up;
    return Icons.thumb_down;
  }
} 