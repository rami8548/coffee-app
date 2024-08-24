import 'package:flutter/material.dart';
import 'package:food/Core/Helper.dart';
import 'package:google_fonts/google_fonts.dart';

class Comment extends StatelessWidget {
   Comment({super.key,

  required this.onPress,
  required this.date,
  required this.date1,
  required this.message,
  required this.text,
  });
  String text; String date; String message; String date1;
  void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 5),
              Container(
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    Helper.getTimeOnly(date1),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                text,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              const SizedBox(width: 8),
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(date)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            message,
            style: GoogleFonts.aladin(fontSize: 18, fontWeight: FontWeight.w300),
          ),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Container(
          //     width: 120,
          //     decoration: BoxDecoration(
          //       color: Colors.teal,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Center(
          //       child: GestureDetector(
          //         onTap: onPress,
          //         child: const Text(
          //           "reply",
          //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Divider(),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
