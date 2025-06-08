import 'package:flutter/material.dart';
import '../reviews/review_screen.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,  // so it doesn’t draw a colored bar
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1) Congrats header
              Text(
                'CONGRATS!!!!!!!!!!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // 2) Subheader
              Text(
                'You matched with',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 8),

              // 3) Matched name
              Text(
                'Apple',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // 4) Heart‑over‑image stack
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Image with black border
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      child: Image.asset(
                        'assets/images/tree.png',
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Pink heart outline
                    Icon(
                      Icons.favorite_border,
                      size: 300,
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 5) Description
              Text(
                'After sitting under this tree for an adequate amount of time:',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 24),

              // 6) Button to go rate & review
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ReviewScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'RATE & REVIEW',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
