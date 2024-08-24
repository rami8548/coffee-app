import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/FeaturesStore/Data/Home/banners_data_cubit.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Presentation/Category/Screens/Category.dart';
import 'package:food/FeaturesStore/Presentation/Chat/Screens/ChatScreens.dart';
import 'package:food/FeaturesStore/Presentation/Product/Screens/ProductDetails.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/AiFilter.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/AiFilterParametr.dart';
import 'package:food/FeaturesStore/Presentation/Product/Widget/FilterData.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreenUsers extends StatelessWidget {
  const HomeScreenUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannersDataCubit, BannersDataState>(
      listener: (context, state) {
        if (state is LoadingGetBanners) {
          const CircularProgressIndicator();
        }
      },
      builder: (context, state) {
        var cubitBanners = BannersDataCubit.get(context);
        var cubitProduct = ProductCoffeeCubit.get(context);

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .35,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "Coffee",
                              style: GoogleFonts.aboreto(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.filter_alt),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const Aifilterparametr();
                            },
                          ));
                        },
                      ),
                      IconButton(
                        icon:  const Icon(Bootstrap.chat),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChatScreenBot();
                            },
                          ));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate:
                                ProductSearchDelegate(cubitProduct.listProduct),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                state is LoadingGetBanners
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.blue,
                      ))
                    : cubitBanners.listBanners.isEmpty
                        ? const Center(child: Text("Data Empty"))
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .25,
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                height: 230,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: true,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              ),
                              itemCount: cubitBanners.listBanners.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(cubitBanners
                                            .listBanners[itemIndex].image
                                            .toString()),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Category",
                      style: GoogleFonts.aboreto(
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .14,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ListView.separated(
                        padding: const EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return category(
                              NetworkImage(cubitBanners
                                  .listCategory[index].image
                                  .toString()), () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Category(
                                  id: cubitBanners.listCategory[index].id
                                      .toString(),
                                );
                              },
                            ));
                            print(
                                cubitBanners.listCategory[index].id.toString());
                          }, cubitBanners.listCategory[index].name.toString());
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 25,
                          );
                        },
                        itemCount: cubitBanners.listCategory.length),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Product",
                      style: GoogleFonts.aboreto(
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                BlocConsumer<ProductCoffeeCubit, ProductCoffeeState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .305,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return product(cubitProduct.listProduct[index], () {
                            cubitProduct.addAndRemoveCart(
                                id: cubitProduct.listProduct[index].id,
                                iduser: CacheHelper.getData(key: "idUser"),
                                imageUrl:
                                    cubitProduct.listProduct[index].imageUrl,
                                name: cubitProduct.listProduct[index].name,
                                flavorNotes:
                                    cubitProduct.listProduct[index].flavorNotes,
                                price: cubitProduct.listProduct[index].price,
                                review: cubitProduct.listProduct[index].review,
                                description:
                                    cubitProduct.listProduct[index].description,
                                iddoc: cubitProduct.listProduct[index].id,
                                caffeineContent: cubitProduct
                                    .listProduct[index].caffeineContent,
                                contains:
                                    cubitProduct.listProduct[index].contains,
                                ingredients:
                                    cubitProduct.listProduct[index].ingredients,
                                sizes: cubitProduct.listProduct[index].sizes,
                                origin: cubitProduct.listProduct[index].origin);
                          }, () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProductDetails(
                                  productModel:

                                           cubitProduct.listProduct[index]

                                );
                              },
                            ));
                          },
                              cubitProduct.idSets.contains(
                                      cubitProduct.listProduct[index].id)
                                  ? Colors.red
                                  : Colors.white);
                        },
                        itemCount:
                             cubitProduct.listProduct.length,

                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                      ),
                    );
                  },
                  listener: (context, state) {},
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget category(ImageProvider image, void Function()? onTap, String name) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: image,
            radius: 35,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(name)
        ],
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
