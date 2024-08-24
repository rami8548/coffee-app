
import 'package:flutter/material.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Register/Presentation/Screens/Register.dart';
import 'package:food/FeaturesStore/Presentation/OnBoarding/Screens/OnBoardingThree.dart';
import 'package:food/FeaturesStore/Presentation/OnBoarding/Screens/OnBoardingTwo.dart';
import 'package:food/FeaturesStore/Presentation/OnBoarding/Widget/Smoothing.dart';
import 'package:icons_plus/icons_plus.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  List<Widget> pages = [
    const OnBoardingTwo(),
    const OnBoardingThree(),
  ];

  PageController pageController = PageController();

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              controller: pageController,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
            Positioned(
                bottom: 20,
                child: Row(
                  children: [
                    currentIndex == pages.length - 1
                        ? SizedBox(
                      width: 70,
                    )
                        : SizedBox(
                      width: 150,
                    ),
                    currentIndex == pages.length - 1
                        ? InkWell(
                        onTap: () {
                          pageController.previousPage(
                              duration: const Duration(seconds: 2),
                              curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white)
                          ),
                          child:Row(
                            children: [
                              Icon(Icons.arrow_back_ios),

                              Text("Back"),
                            ],
                          ),
                        ))
                        : const Text(""),
                    SizedBox(
                      width: 30,
                    ),
                    Smoothing(pageController: pageController),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(
                        onTap: ()async {
                          currentIndex == pages.length - 1
                              ? Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Register();
                                },
                              ), (route) => false)
                              : pageController.nextPage(
                              duration: const Duration(seconds: 2),
                              curve: Curves.ease);
                          await CacheHelper.saveData(key: "OnBoarding", value: true);

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)
                          ),
                          child:Row(
                            children: [
                              Text("Next"),
                              Icon(Icons.arrow_forward_ios),


                            ],
                          ),
                        ))
                  ],
                )),
            Positioned(
                right: 30,
                child: Align(
                  alignment: Alignment.topRight,
                  child: currentIndex == pages.length - 1
                      ? const Text("")
                      : InkWell(
                    onTap: () async{
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Register();
                            },
                          ), (route) => false);
                      await CacheHelper.saveData(key: "OnBoarding", value: true);

                    },
                    child: Text(
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        "Skip"),
                  ),
                ))
          ],
        ));
  }
}
