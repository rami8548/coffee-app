import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentBody extends StatelessWidget {
  const ContentBody(
      {super.key,
        required this.fontWeight,
        required this.image,
        required this.text,
        required this.text1,
        required this.color,
        required this.fontSize});

  final String image;
  final String text;
  final String text1;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height:50,),
        Image.asset(image),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(top: 12,left: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              text1,
              style: GoogleFonts.alatsi(
                color: Colors.white,
                fontWeight: fontWeight,
                fontSize: 42,
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
        )
      ],
    );
  }
}
