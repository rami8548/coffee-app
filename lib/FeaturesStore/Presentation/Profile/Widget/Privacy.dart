import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Helper.dart';
import 'package:food/Features/Register/Data/auth_cubit.dart';
import 'package:food/FeaturesStore/Data/HomeScoffee/home_coffee_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Privacy",
          style: GoogleFonts.aladin(),
        ),
      ),
      body: BlocConsumer<HomeCoffeeCubit, HomeCoffeeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCoffeeCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "- ${Helper.privacyOne}",
                    style: GoogleFonts.aboreto(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "- ${Helper.peivacyTwo}",
                    style: GoogleFonts.aboreto(),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "FAQ's",
                      style: GoogleFonts.aboreto(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: title(
                    isvisable: cubit.isvisable1 ? true : false,
                    title: "What types of coffee beans",
                    desc:
                        "Answer: We use a variety of high-quality Arabica and Robusta beans sourced from renowned coffee-growing regions",
                    onPress: () {
                      cubit.changeq1();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: title(
                    isvisable: cubit.isvisable2 ? true : false,
                    title: "Q: What is [Your Coffee App Name]?",
                    desc:
                        "A: [ R Coffee] is your one-stop app for all things coffee. Discover new coffee products, get brewing tips, and connect with other coffee enthusiasts.",
                    onPress: () {
                      cubit.changeq2();
                    },
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Contact Us : -",
                        style: GoogleFonts.aboreto(),
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Customer Support",
                        style: GoogleFonts.aboreto(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        _launchUrlWhatsApp();
                      },
                      icon: const Icon(
                        Bootstrap.whatsapp,
                        color: Colors.teal,
                        size: 45,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _launchUrlFaceBook();
                      },
                      icon: const Icon(
                        Bootstrap.facebook,
                        color: Colors.blue,
                        size: 45,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _launchUrlLinkedIn();
                      },
                      icon: const Icon(
                        Bootstrap.github,
                        size: 45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrlWhatsApp() async {
    Uri uri = Uri.parse("https://wa.me/+201006141175");
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> _launchUrlFaceBook() async {
    Uri uri =
        Uri.parse("https://www.facebook.com/ana.ragaey.1?mibextid=ZbWKwL");
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> _launchUrlLinkedIn() async {
    Uri uri = Uri.parse("https://github.com/ragaie-ahmed");
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Widget title({
    required bool isvisable,
    required String title,
    required String desc,
    required void Function()? onPress,
  }) {
    return Column(
      children: [
        MaterialButton(
          onPressed: onPress,
          color: Colors.blue,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
              )
            ],
          ),
        ),
        Visibility(visible: isvisable, child: Text(desc))
      ],
    );
  }
}
