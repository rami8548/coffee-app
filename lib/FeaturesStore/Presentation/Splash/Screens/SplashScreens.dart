import 'package:flutter/material.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Register/Presentation/Screens/Register.dart';
import 'package:food/FeaturesStore/Presentation/HomeCoffe.dart';
import 'package:food/FeaturesStore/Presentation/OnBoarding/Screens/OnBoardingOne.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  _SplashscreensState createState() => _SplashscreensState();
}

class _SplashscreensState extends State<SplashScreens>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigateToNextScreen();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Optional delay for UX
    if (CacheHelper.getData(key: "OnBoarding") == true) {
      CacheHelper.getData(key: "idUser") != null
          ? Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const HomeCoffee();
        }),
            (route) => false,
      )
          : Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const Register();
        }),
            (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const OnboardingBody();
        }),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: const Center(
                child: Text(
                  "Coffee_App...",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
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
