import 'package:flutter/material.dart';
import 'package:food/FeaturesStore/Model/CategoryModel.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:google_fonts/google_fonts.dart';

class Detailscategory extends StatelessWidget {
  Detailscategory({super.key, required this.categorymodel});

  ProductModel categorymodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(categorymodel.imageUrl),
                        fit: BoxFit.fill),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Description",
                    style: GoogleFonts.aladin(
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    categorymodel.name,
                    style: GoogleFonts.aboreto(
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
