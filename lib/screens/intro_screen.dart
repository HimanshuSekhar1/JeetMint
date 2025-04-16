import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, String>> introData = [
    {
      "image": "assets/images/slide 1.png",
      "text": "Play fun brain games and earn money!"
    },
    {
      "image": "assets/images/slide 2.png",
      "text": "Compete live with players across India!"
    },
    {
      "image": "assets/images/FrontLogo.png",
      "text": "Jeeto cash daily on JeetMint!"
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel(); // Clear any existing timer
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_controller.hasClients) {
        if (_currentIndex < introData.length - 1) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          _timer?.cancel(); // Stop auto-slide at the last slide
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cleanup timer when screen is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: introData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _startAutoSlide(); // Restart auto-slide on manual swipe
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      introData[index]['image']!,
                      height: 300,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      introData[index]['text']!,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              },
            ),
            Positioned(
              right: 20,
              bottom: 30,
              child: TextButton(
                onPressed: () {
                  _timer?.cancel(); // Stop auto-slide when skipping
                  Get.offNamed('/login');
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
