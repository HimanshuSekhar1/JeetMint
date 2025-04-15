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
      "image": "assets/images/slide3.jpg",
      "text": "Jeeto cash daily on JeetMint!"
    },
  ];

  Timer? autoSlideTimer;

  @override
  void initState() {
    super.initState();
    autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < introData.length - 1) {
        _controller.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    autoSlideTimer?.cancel();
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
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
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
