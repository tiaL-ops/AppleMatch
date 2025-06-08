import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // Controllers for the two text questions
  final TextEditingController _applesController = TextEditingController();
  final TextEditingController _ideasController = TextEditingController();

  // Slider value for “Do you feel smarter?”
  double _smartness = 5;

  // Index of selected emoji (0,1,2), or -1 if none yet
  int _satisfactionIndex = -1;

  // List your three emoji assets here in order
  final List<String> _emojiAssets = [
    'assets/images/treeUp.png',
    'assets/images/bof.png',
    'assets/images/wtf.png',
  ];

  @override
  void dispose() {
    _applesController.dispose();
    _ideasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header image ---
              Center(
                child: Image.asset(
                  'assets/images/tree.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 24),

              // --- Title ---
              const Text(
                'Rate & Review',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // 1) How many apples?
              const Text('1. How many apples fell on your head?'),
              const SizedBox(height: 8),
              TextField(
                controller: _applesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
              ),

              const SizedBox(height: 24),

              // 2) How many new ideas?
              const Text(
                '2. How many new ideas entered\nyour small brain?',
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _ideasController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
              ),

              const SizedBox(height: 24),

              // 3) Do you feel smarter?
              const Text('3. Do you feel smarter?'),
              const SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Colors.black,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 16),
                ),
                child: Slider(
                  min: 0,
                  max: 10,
                  divisions: 10,
                  value: _smartness,
                  onChanged: (v) => setState(() => _smartness = v),
                ),
              ),
              Row(
                children: const [
                  Text('0'),
                  Spacer(),
                  Text('10'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Text('dumb dummy'),
                  Spacer(),
                  Text('Newtonion genius'),
                ],
              ),

              const SizedBox(height: 32),

              // 4) Overall satisfaction
              const Text('4. Overall satisfaction:'),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _emojiAssets.length,
                  (index) => GestureDetector(
                    onTap: () =>
                        setState(() => _satisfactionIndex = index),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _satisfactionIndex == index
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        _emojiAssets[index],
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
