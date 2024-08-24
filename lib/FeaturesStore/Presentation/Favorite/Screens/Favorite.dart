import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Model/ProductModelCoffee.dart';
import 'package:food/FeaturesStore/Presentation/Product/Screens/ProductDetails.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    var cubitfavorite = ProductCoffeeCubit.get(context)..getFavorite(CacheHelper.getData(key: "idUser"));

    return BlocConsumer<ProductCoffeeCubit, ProductCoffeeState>(
      builder: (context, state) {
        return state is LoadingGetFavorites
            ? const Center(child: CircularProgressIndicator())
            : cubitfavorite.favorites.isEmpty
            ? const Center(
          child: Text("Your favorite list is empty 😔",
              style: TextStyle(fontSize: 20, color: Colors.white)),
        )
            : ListView.builder(
          padding: EdgeInsets.all(100),
          itemBuilder: (context, index) {
            return favorite(
              category: cubitfavorite.favorites[index],
              onPress: () {
                cubitfavorite.deletfavorite(
                    cubitfavorite.favorites[index].id,
                    CacheHelper.getData(key: "idUser"));
              },
              onPress1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductDetails(
                          productModel:
                          cubitfavorite.favorites[index]);
                    },
                  ),
                );
              },
            );
          },
          itemCount: cubitfavorite.favorites.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget favorite(
      {required ProductModel category,
        required void Function()? onPress,
        required void Function()? onPress1}) {
    return Container(
      height: 290,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onPress1,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(category.imageUrl),
              ),
            ),
          ),
          Positioned(
            top: 80,
            child: Container(
              height: 150,
              width: 200,
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      "\$${category.price}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: onPress,
                      icon: const Icon(
                        Icons.delete,
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
