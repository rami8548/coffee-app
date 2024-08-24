import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/FeaturesStore/Data/HomeScoffee/home_coffee_cubit.dart';

class HomeCoffee extends StatelessWidget {
  const HomeCoffee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCoffeeCubit, HomeCoffeeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitHome = HomeCoffeeCubit.get(context);
        return Scaffold(
          body:cubitHome.screens[cubitHome.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black26,
            currentIndex: cubitHome.currentIndex,
            onTap: (value) {
              cubitHome.changeIndex(value);
            },
            selectedIconTheme: const IconThemeData(color: Colors.teal),
            selectedItemColor: Colors.white,
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            items: [
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                      backgroundColor: cubitHome.currentIndex == 0
                          ? Colors.teal
                          : Colors.transparent,
                      child: const Icon(Icons.home_filled)),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                      backgroundColor: cubitHome.currentIndex == 1
                          ? Colors.teal
                          : Colors.transparent,
                      child: const Icon(Icons.favorite_border)),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                      backgroundColor: cubitHome.currentIndex == 2
                          ? Colors.teal
                          : Colors.transparent,
                      child: const Icon(Icons.shopping_cart)),
                  label: "Cart"),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                      backgroundColor: cubitHome.currentIndex == 3
                          ? Colors.teal
                          : Colors.transparent,
                      child: const Icon(Icons.person)),
                  label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
