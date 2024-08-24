import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,required this.onPress,required this.textString});
  void Function()? onPress;
  String textString;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: MaterialButton(
        onPressed:onPress,
        color: Colors.blue,
        height: 50,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        child: Center(
          child: Text(
         textString,
            style:
                GoogleFonts.aladin(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
