import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUsage{
 static message({
   required BuildContext context,
   required String result,
   required Color color
}){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(result),
      backgroundColor:color,
        duration: const Duration(seconds: 1),
    ));
  }
}
