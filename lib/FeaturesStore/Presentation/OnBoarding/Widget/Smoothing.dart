import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Smoothing extends StatefulWidget {
  const Smoothing({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<Smoothing> createState() => _SmoothingState();
}

class _SmoothingState extends State<Smoothing> {
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      effect:  ExpandingDotsEffect(
          spacing: 6.0,
          radius: 15.0,


          strokeWidth: 1.5,

          dotColor:Colors.white,

          activeDotColor:Colors.white

      ),
      controller: widget.pageController, // PageController
      count: 2,


      // your preferred effect
    );
  }
}
