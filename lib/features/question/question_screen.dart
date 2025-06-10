import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_controller.hasClients && (_controller.page ?? 0) < 5) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 179, 142),
      body: SafeArea(
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildQuestion('Do you ever feel lost?'),
            _buildQuestion('Do you ever feel dumb?'),
            _buildQuestion('Do you ever feel pointless?'),
            _buildPrompt('DON\'T WORRY'),
            _buildCentered(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Daddy Apple is here to help',
                    style: const TextStyle(
                      fontFamily: 'BubblegumSans',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(221, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                 
                  SvgPicture.asset('assets/icons/apple.svg', height: 120),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/map'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(221, 21, 20, 20), backgroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'SAVE ME FATHER',
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return _buildCentered(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'BubblegumSans',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(221, 255, 254, 254),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('YES', const Color.fromARGB(255, 220, 83, 83), Colors.black87),
                _buildActionButton('YES in green', const Color.fromARGB(255, 87, 168, 83), Colors.black87),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrompt(String text) {
    return _buildCentered(
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'BubblegumSans',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(221, 255, 254, 254),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color bg, Color fg) {
    return ElevatedButton(
      onPressed: _nextPage,
      style: ElevatedButton.styleFrom(
        foregroundColor: fg, backgroundColor: bg,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: const StadiumBorder(),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'BubblegumSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCentered({required Widget child}) => GestureDetector(
        onTap: _nextPage,
        behavior: HitTestBehavior.opaque,
        child: Center(child: child),
      );
}
