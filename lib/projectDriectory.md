newTon/
├── README.md
├── pubspec.yaml
├── assets/
│   └── data/
│       └── apple_trees.json       # Mock dataset of apple trees
├── lib/
│   ├── main.dart                  # Entry point
│   ├── core/
│   │   ├── constants.dart         # Any constant values (maturity thressold)
│   │   ├── utils.dart             # Helper functions (e.g., date calc)
│   │   └── location_helper.dart   # For geo + distance calculations
│   ├── models/
│   │   └── tree_model.dart        # AppleTree data model
│   ├── services/
│   │   ├── notification_service.dart # Local notifications logic
│   │   ├── geofencing_service.dart   # Location & proximity handling
│   │   └── storage_service.dart      # Favorites saved in memory/local
│   ├── data/
│   │   └── tree_repository.dart   # Loads & manages mock tree data
│   ├── features/
│   │   ├── map/
│   │   │   ├── map_screen.dart        # Main screen with Google Maps
│   │   │   └── map_controller.dart    # Handles logic (e.g., camera updates)
│   │   ├── tree_details/
│   │   │   ├── tree_details_screen.dart # Info on selected tree
│   │   └── favorites/
│   │       └── favorites_screen.dart   # List of saved trees
│   ├── widgets/
│   │   ├── tree_marker.dart        # Custom map markers
│   │   └── tree_card.dart          # Reusable tree info cards
│   └── app.dart                    # App widget + routes
└── test/
    └── unit_tests/
        └── tree_model_test.dart    # Example unit test
