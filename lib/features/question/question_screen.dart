import 'package:flutter/material.dart';

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
    if (_controller.hasClients && _controller.page! < 5) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // ─────────────────── 1 ───────────────────
            _buildQuestion(
              theme,
              'Do you ever feel lost?',
              _nextPage,
            ),

            // ─────────────────── 2 ───────────────────
            _buildQuestion(
              theme,
              'Do you ever feel dumb?',
              _nextPage,
            ),

            // ─────────────────── 3 ───────────────────
            _buildQuestion(
              theme,
              'Do you ever feel pointless?',
              _nextPage,
            ),

            // ─────────────────── 4 ───────────────────
            // just a tappable “DON’T WORRY”
            _buildCenteredTap(
              theme,
              "DON'T WORRY",
              _nextPage,
            ),

            // ─────────────────── 5 ───────────────────
            // Daddy Apple slide
            _buildCenteredTap(
              theme,
              null, // we’ll build custom child below
              _nextPage,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "DON'T WORRY",
                    style: theme.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Image.asset(
                    'assets/images/daddy_apple.png',
                    height: 200,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Daddy Apple is here to help',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontFamily: 'EuphoriaScript',
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // ─────────────────── 6 ───────────────────
            // Final slide with SAVE ME FATHER
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/map');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black87, backgroundColor: const Color(0xFFCCFFCC),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('SAVE ME FATHER'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(
      ThemeData theme, String text, VoidCallback onNext) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: ' EuphoriaScript',
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('YES', onNext, const Color(0xFFFFCCCC)),
                _buildButton(
                    'YASSSSS', onNext, const Color(0xFFCCFFCC)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenteredTap(
    ThemeData theme,
    String? text,
    VoidCallback onTap, {
    Widget? child,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: child ??
            Text(
              text!,
              style: theme.textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
      ),
    );
  }

  Widget _buildButton(
      String label, VoidCallback onTap, Color background) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87, backgroundColor: background,
        elevation: 0,
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }
}
