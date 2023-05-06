import 'package:flutter/material.dart';

class AnimatedSplashScreenAi extends StatefulWidget {
  const AnimatedSplashScreenAi({Key? key}) : super(key: key);

  @override
  State<AnimatedSplashScreenAi> createState() => _AnimatedSplashScreenAiState();
}

class _AnimatedSplashScreenAiState extends State<AnimatedSplashScreenAi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TextStyle> _animation4;
  late Animation<AlignmentGeometry> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    _animation4 = TextStyleTween(
      begin: const TextStyle(
        fontSize: 35,
      ),
      end: const TextStyle(
        fontSize: 50,
      ),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(67, 34, 103, 1),
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(height: 170),
            AlignTransition(
              alignment: _animation,
              child: Image.asset(
                'assets/chatbot.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 400),
                child: DefaultTextStyleTransition(
                  style: _animation4,
                  child: const Text(
                    'Mind Scape',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
