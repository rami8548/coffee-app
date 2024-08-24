import 'package:flutter/material.dart';
import 'package:food/Core/Helper.dart';
import 'package:food/FeaturesStore/Model/MessageModel.dart';
import 'package:google_fonts/google_fonts.dart';

class comment1 extends StatelessWidget {
   comment1({super.key,required this.messageModel,required this.onPress});
  Messagemodel messageModel; void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Helper.getTimeOnly(messageModel.date),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            const Spacer(),
            Text(
              messageModel.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(messageModel.imageUrl),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          messageModel.content,
          style: GoogleFonts.aladin(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Divider(),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
