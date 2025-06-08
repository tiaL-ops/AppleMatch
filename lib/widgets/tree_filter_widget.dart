import 'package:flutter/material.dart';

class TreeFilterWidget extends StatefulWidget {
  final Function(int minHeight, int maxHeight, int minGirth, int maxGirth, int minAge, int maxAge) onFiltersChanged;
  final VoidCallback onClearFilters;

  const TreeFilterWidget({
    Key? key,
    required this.onFiltersChanged,
    required this.onClearFilters,
  }) : super(key: key);

  @override
  State<TreeFilterWidget> createState() => _TreeFilterWidgetState();
}

class _TreeFilterWidgetState extends State<TreeFilterWidget> {
  // Filter ranges
  RangeValues heightRange = const RangeValues(1, 50);  // feet
  RangeValues girthRange = const RangeValues(1, 200);  // inches
  RangeValues ageRange = const RangeValues(1, 1500);   // days

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Trees 🌳',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    heightRange = const RangeValues(1, 50);
                    girthRange = const RangeValues(1, 200);
                    ageRange = const RangeValues(1, 1500);
                  });
                  widget.onClearFilters();
                },
                child: const Text('Clear All'),
              ),
            ],
          ),
          
          const SizedBox(height: 20),

          // Height Filter
          _buildFilterSection(
            '📏 Height (ft)',
            '${heightRange.start.round()} - ${heightRange.end.round()} ft',
            heightRange,
            1,
            50,
            (values) {
              setState(() => heightRange = values);
              _updateFilters();
            },
          ),

          const SizedBox(height: 20),

          // Girth Filter
          _buildFilterSection(
            '⭕ Girth (inches)',
            '${girthRange.start.round()} - ${girthRange.end.round()}"',
            girthRange,
            1,
            200,
            (values) {
              setState(() => girthRange = values);
              _updateFilters();
            },
            description: 'Inches around the tree trunk at a point of 4.5 feet above ground and it a manner to calculate the DBH (diameter at breast height)',
          ),

          const SizedBox(height: 20),

          // Age Filter  
          _buildFilterSection(
            '🎂 Days Old (& Rings)',
            '${ageRange.start.round()} - ${ageRange.end.round()} days',
            ageRange,
            1,
            1500,
            (values) {
              setState(() => ageRange = values);
              _updateFilters();
            },
            description: 'Number of tree rings',
          ),

          const SizedBox(height: 20),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    String subtitle,
    RangeValues values,
    double min,
    double max,
    Function(RangeValues) onChanged, {
    String? description,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
        const SizedBox(height: 8),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: (max - min).round(),
          activeColor: theme.colorScheme.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _updateFilters() {
    widget.onFiltersChanged(
      heightRange.start.round(),
      heightRange.end.round(),
      girthRange.start.round(),
      girthRange.end.round(),
      ageRange.start.round(),
      ageRange.end.round(),
    );
  }
} 