import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.textEditingController,
      this.isobsecure = false,
      required this.hintText,
      required this.iconData,@required this.onTap,
      required this.validate,
         this.helperText
      });

  TextEditingController textEditingController;
  bool isobsecure;
  IconData iconData;
  String hintText;
  String? Function(String?)? validate;
  void Function()? onTap;
  String ?helperText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validate,
        controller: textEditingController,

        obscureText: isobsecure,
        decoration: InputDecoration(
          helperText:helperText ,

            labelText: hintText,
            labelStyle: GoogleFonts.aladin(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            suffixIcon: GestureDetector(
                onTap:onTap ,
                child: Icon(iconData)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
