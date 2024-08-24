import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/FeaturesStore/Data/Home/banners_data_cubit.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Presentation/Product/Screens/ProductDetails.dart';

class Category extends StatefulWidget {
  const Category({super.key, required this.id});

  final String id;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    // تحميل البيانات في initState
    BlocProvider.of<BannersDataCubit>(context).getCategoryId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<BannersDataCubit, BannersDataState>(
        listener: (context, state) {
          if (state is ErrorGetCategoryId) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingGetCategoryId) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessGetCategoryId) {
            var cubitCategory = BannersDataCubit.get(context);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              itemCount: cubitCategory.listCategoryId.length,
              itemBuilder: (context, index) {
                final category = cubitCategory.listCategoryId[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return ProductDetails(productModel: category);
                        }));
                  },
                  child: CategoryTheme(
                    category: category,
                    onFavoriteToggle: () {
                      ProductCoffeeCubit.get(context).addAndRemoveFavorite(
                        idUser: CacheHelper.getData(key: "idUser"),
                        id: category.id,
                        imageUrl: category.imageUrl,
                        name: category.name,
                        flavorNotes: category.flavorNotes,
                        price: category.price,
                        review: category.review,
                        description: category.description,
                        caffeineContent: category.caffeineContent,
                        contains: category.contains,
                        ingredients: category.ingredients,
                        sizes: category.sizes,
                        origin: category.origin,
                      );
                      print(category.id.toString());
                    },
                   icon: Icon(Icons.favorite_border,color: ProductCoffeeCubit.get(context)
                       .idFavoriteProduct
                       .contains(category.id)?Colors.red:Colors.white,)

                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load categories.'));
          }
        },
      ),
    );
  }

  Widget CategoryTheme({
    required ProductModel category,
    required VoidCallback onFavoriteToggle,
    required Icon icon
  }) {
    return Container(
      height: 330,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(category.imageUrl),
            ),
          ),
          Positioned(
            top: 80,
            child: Container(
              height: 180,
              width: 200,
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category.name,
                          style: const TextStyle(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: onFavoriteToggle,
                          icon: icon,
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category.review.toString(),
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Icon(Icons.star,color: Colors.yellow,)
                    ],
                  )
                    ,
                    // Text(
                    //   "\$${category.price}",
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
