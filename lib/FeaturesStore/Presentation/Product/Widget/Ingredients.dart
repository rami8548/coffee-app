import 'package:flutter/material.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/test.dart';
import 'package:google_fonts/google_fonts.dart';

class Ingredients extends StatelessWidget {
   Ingredients({super.key,required this.productModel});
ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Ingredients...:",style: GoogleFonts.aladin(fontSize: 20),),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Video:",style: GoogleFonts.aladin(fontSize: 20),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyHomePage(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${productModel.ingredients.toString().replaceAll(",", "\n- ").replaceAll("[", "").replaceAll("]", "")}",style: GoogleFonts.aladin(fontSize: 18,color: Colors.yellow),),
          ),
        ],
      ),
    );
  }
}
