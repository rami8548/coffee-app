import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Register/Model/UserModel.dart';
import 'package:food/FeaturesStore/Presentation/Cart/Screens/CartScreens.dart';
import 'package:food/FeaturesStore/Presentation/Favorite/Screens/Favorite.dart';
import 'package:food/FeaturesStore/Presentation/HomeStore/HomeScreenUsers.dart';
import 'package:food/FeaturesStore/Presentation/Profile/Screens/Profile.dart';
import 'package:meta/meta.dart';

part 'home_coffee_state.dart';

class HomeCoffeeCubit extends Cubit<HomeCoffeeState> {
  HomeCoffeeCubit() : super(HomeCoffeeInitial());
  static HomeCoffeeCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>screens=[
    const HomeScreenUsers(),
    const Favorite(),
    CartScreen(),
    const Profile(),

  ];
  void changeIndex(int value){
    currentIndex=value;
    emit(SuccessChangeIndex());
  }
bool isvisable1=false;
  void changeq1(){
    isvisable1=!isvisable1;
    emit(SuccessChangeQ1());
  }
  bool isvisable2=false;
  void changeq2(){
    isvisable2=!isvisable2;
    emit(SuccessChangeQ2());
  }

}
