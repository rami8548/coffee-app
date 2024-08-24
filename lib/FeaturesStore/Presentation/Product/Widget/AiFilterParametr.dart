import 'package:flutter/material.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/AiFilter.dart';
import 'package:food/Widget/Custom/CustomButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Aifilterparametr extends StatefulWidget {
  const Aifilterparametr({
    Key? key,
  }) : super(key: key);

  @override
  _AifilterparametrState createState() => _AifilterparametrState();
}

class _AifilterparametrState extends State<Aifilterparametr> {
  // List of items for the dropdown
  List<String> dropdownItems = ["L", "M", "S"];
  List<String> dropdownItems1 = ["No", "Yes"];

  // Selected item from the dropdown
  String? selectedItem;
  String? selectedItem1;
  double value1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SuggestData",
          style: GoogleFonts.aladin(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              textAlign: TextAlign.center,
              "Let us suggest the perfect \ncoffee for you! ☕️",
              style: GoogleFonts.aladin(
                  fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          Slider(
            min: 0,
            activeColor: Colors.blue,
            max: 100,
            value: value1,
            onChanged: (value) {
              setState(() {
                value1 = value;
              });
            },
          ),
          Text(
              textAlign: TextAlign.center,
              "${value1.toInt()}",
              style: GoogleFonts.aladin(
                  fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Select Size",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton<String>(
                value: selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                },
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Do you want it to contain caffeine",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton<String>(
                value: selectedItem1,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem1 = newValue;
                  });
                },
                items:
                    dropdownItems1.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 20),
          CustomButton(
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FutureBuilder(
                      future: Future.delayed(const Duration(seconds: 3)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Aifilter(price: value1.toInt());
                        } else {
                          return  Scaffold(
                            body: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoadingAnimationWidget.threeRotatingDots(color: Colors.blue, size: 150),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Just a moment, we're preparing your product with care! 😊",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              );
            },
            textString: "Suggest",
          )


          // CustomButton(
          //   onPress: () {
          //     Navigator.push(
          //       context,
          //       PageRouteBuilder(
          //         pageBuilder: (context, animation, secondaryAnimation) {
          //           return Aifilter(price: value1.toInt());
          //         },
          //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //           var begin = Offset(1.0, 0.0);
          //           var end = Offset.zero;
          //           var curve = Curves.easeInOut;
          //
          //           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          //           var offsetAnimation = animation.drive(tween);
          //
          //           return SlideTransition(
          //             position: offsetAnimation,
          //             child: child,
          //           );
          //         },
          //         transitionDuration: Duration(seconds: 3),
          //       ),
          //     );
          //   },
          //   textString: "Suggest",
          // )

        ],
      ),
    );
  }
}
