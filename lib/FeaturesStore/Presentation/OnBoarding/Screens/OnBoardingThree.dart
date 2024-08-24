
import 'package:flutter/material.dart';
import 'package:food/FeaturesStore/Presentation/OnBoarding/Widget/ContentBody.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(right: 4,left: 4),
      child:  ContentBody(image: "Assets/Images/th (3).jpeg",
        text1: "Let's Get \nStarted",

        color: Theme.of(context).colorScheme.primary,
        text: "Sign in or Create or create an account to begin. ",
        fontWeight: FontWeight.bold,
        fontSize: 18,

      ),
    );
  }
}
