
import 'package:flutter/material.dart';
import 'package:food/Core/Helper.dart';
import 'package:food/FeaturesStore/Presentation/OnBoarding/Widget/ContentBody.dart';

class OnBoardingTwo extends StatelessWidget {
  const OnBoardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(right: 4,left: 4),
      child:  ContentBody(image: "Assets/Images/th.jpeg",
        text1: "Welcom To \nR Coffe!",
        color: Theme.of(context).colorScheme.primary,
        text: "Customize Your drink and place Order",
        fontWeight: FontWeight.bold,
        fontSize: 18,

      ),
    );
  }
}
