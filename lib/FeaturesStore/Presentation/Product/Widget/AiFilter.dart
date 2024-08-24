import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Presentation/Product/Screens/ProductDetails.dart';
import 'package:google_fonts/google_fonts.dart';

class Aifilter extends StatefulWidget {
   Aifilter({super.key,required this.price});
int price;
  @override
  State<Aifilter> createState() => _AifilterState();
}

class _AifilterState extends State<Aifilter> {
  @override
  void initState() {
    ProductCoffeeCubit.get(context).getProductSearch(widget.price);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubitProduct=ProductCoffeeCubit.get(context);
    return Scaffold(
appBar: AppBar(),
      body: BlocConsumer<ProductCoffeeCubit, ProductCoffeeState>(
        builder: (context, state) {
          if(state is SuccessSearchCoffee){
            return cubitProduct.searchProduct.isEmpty?const Center(
              child: Text("Your Suggest list is empty 😔",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ) :ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20,),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return product(cubitProduct.searchProduct[index], () {
                      cubitProduct.addAndRemoveCart(
                          id: cubitProduct.searchProduct[index].id,
                          iduser: CacheHelper.getData(key: "idUser"),
                          imageUrl:
                          cubitProduct.searchProduct[index].imageUrl,
                          name: cubitProduct.searchProduct[index].name,
                          flavorNotes:
                          cubitProduct.searchProduct[index].flavorNotes,
                          price: cubitProduct.searchProduct[index].price,
                          review: cubitProduct.searchProduct[index].review,
                          description:
                          cubitProduct.searchProduct[index].description,
                          iddoc: cubitProduct.searchProduct[index].id,
                          caffeineContent: cubitProduct
                              .searchProduct[index].caffeineContent,
                          contains:
                          cubitProduct.searchProduct[index].contains,
                          ingredients:
                          cubitProduct.searchProduct[index].ingredients,
                          sizes: cubitProduct.searchProduct[index].sizes,
                          origin: cubitProduct.searchProduct[index].origin);
                    }, () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ProductDetails(
                            productModel:cubitProduct.searchProduct[index],
                          );
                        },
                      ));
                    },
                        cubitProduct.idSets.contains(
                            cubitProduct.searchProduct[index].id)
                            ? Colors.red
                            : Colors.white);
                  },
                  itemCount:cubitProduct.searchProduct.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
  Widget product(ProductModel product, void Function()? onPress,
      void Function()? onPress1, Color color) {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(color: Colors.black26),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPress1,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              height: 150,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(product.imageUrl.toString()),
                      fit: BoxFit.fill)),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${product.review}"),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                      onPressed: onPress,
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 40,
                        color: color,
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
