import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsProduct extends StatelessWidget {
   DetailsProduct({super.key,

    required this.onPress,
    required this.productModel,
    required this.color,


  });
  ProductModel productModel; void Function()? onPress; Color color;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Description",
              style: GoogleFonts.aladin(fontSize: 30),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Text(
              productModel.description,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: onPress,
              color: color,
              child: Text(
                "Add To Cart",
                style: GoogleFonts.aboreto(),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    sandboxMode: true,
                    clientId: "AUnvhu_bWgDgb6kRfTL5PXj8lxgsax-DsuRr7I0gM9l9VUC0ktqkSWGHiPOkH8xGMGrz-t4w8vzkjazF",
                    secretKey: "EFyyws5rtdMyfYwWTgNKakKez4OzD0jsggipyiEje_iY838EUoCv8WbCLZQDwECSgn1PcA1zTTfuTLSR",
                    transactions: [
                      {
                        "amount": {
                          "total": productModel.price,
                          "currency": "USD",
                          "details": {
                            "subtotal": productModel.price,
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description": "The payment transaction description.",
                        "item_list": {
                          "items":[
                            {
                              "name": productModel.name,
                              "quantity": 1,
                              "price":productModel.price,
                              "currency": "USD"
                            },
                          ]
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      log("onSuccess: $params");
                      Navigator.pop(context);
                    },
                    onError: (error) {
                      log("onError: $error");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      print('cancelled:');
                      Navigator.pop(context);
                    },
                  ),
                ));
              },
              color: Colors.blueGrey,
              child: Text(
                "CheckOut",
                style: GoogleFonts.aboreto(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
