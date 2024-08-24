import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ProductCoffeeCubit.get(context)
      ..getCart(CacheHelper.getData(key: "idUser"));

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: BlocConsumer<ProductCoffeeCubit, ProductCoffeeState>(
        listener: (context, state) {
          if (state is ProductCoffeeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          var cubit = ProductCoffeeCubit.get(context);
          if (state is ProductCoffeeLoading || state is LoadinAddCart) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductCoffeeSuccess ||
              state is SuccessGetCart ||
              state is ProductCoffeeTotalPriceUpdated ||
              state is ProductCoffeeQuantityUpdated ||
              state is SuccessRemoveCart) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: cubit.cart.length,
                    itemBuilder: (context, index) {
                      final item = cubit.cart[index];
                      return product(
                        product: item,
                        onPress: () {
                          cubit.decrementQuantity(item.id);
                        },
                        onPress1: () {
                          cubit.incrementQuantity(item.id);
                        },
                        onPres2: () {
                          cubit.removeFromCart(
                              item.id, CacheHelper.getData(key: "idUser"));
                        },
                        color: Colors.red,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Price: \$${cubit.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                MaterialButton(
                  color: Colors.teal,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckoutView(
                        sandboxMode: true,
                        clientId: "AUnvhu_bWgDgb6kRfTL5PXj8lxgsax-DsuRr7I0gM9l9VUC0ktqkSWGHiPOkH8xGMGrz-t4w8vzkjazF",
                        secretKey: "EFyyws5rtdMyfYwWTgNKakKez4OzD0jsggipyiEje_iY838EUoCv8WbCLZQDwECSgn1PcA1zTTfuTLSR",
                        transactions: [
                          {
                            "amount": {
                              "total": cubit.totalPrice.toString(),
                              "currency": "USD",
                              "details": {
                                "subtotal": cubit.totalPrice.toString(),
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description": "The payment transaction description.",
                            "item_list": {
                              "items": _getPaypalItems(cubit.cart),
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
                  child: const Text("CheckOut"),
                )

              ],
            );
          } else {
            return const Center(child: Text('No items in cart'));
          }
        },
      ),
    );
  }
  List<Map<String, dynamic>> _getPaypalItems(List<ProductModel> cart) {
    return cart.map((item) {
      return {
        "name": item.name,
        "quantity": item.quantity,
        "price": item.price.toString(),
        "currency": "USD"
      };
    }).toList();
  }

  Widget product({
    required ProductModel product,
    required void Function()? onPress,
    required void Function()? onPres2,
    required void Function()? onPress1,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      width: 150,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black26),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(product.imageUrl.toString()),
                    fit: BoxFit.fill)),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  product.name,
                  style: GoogleFonts.aboreto(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "price ${product.price}" r"$",
                  style: GoogleFonts.aboreto(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(70)),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: onPress,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Quantity: ${product.quantity}'),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(70)),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: onPress1,
                    ),
                  ),
                ],
              ),

              MaterialButton(
                onPressed: onPres2,
                color: Colors.black,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "remove",
                  style: GoogleFonts.alatsi(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

