import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Chat/Data/chat_model_cubit.dart';
import 'package:food/Features/HomeScreen/Data/home_screen_cubit.dart';
import 'package:food/Features/Register/Data/auth_cubit.dart';
import 'package:food/Features/Register/Presentation/Screens/Register.dart';
import 'package:food/FeaturesStore/Data/Home/banners_data_cubit.dart';
import 'package:food/FeaturesStore/Data/HomeScoffee/home_coffee_cubit.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Presentation/AddProduct/AddProduct.dart';
import 'package:food/FeaturesStore/Presentation/AddProduct/add_product_cubit.dart';
import 'package:food/FeaturesStore/Presentation/HomeCoffe.dart';
import 'package:food/FeaturesStore/Presentation/OnBoarding/Screens/OnBoardingOne.dart';
import 'package:food/FeaturesStore/Presentation/Splash/Screens/SplashScreens.dart';
import 'package:food/test.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => HomeCoffeeCubit(),),
        BlocProvider(create: (context) => AddProductCubit(),),
        BlocProvider(create: (context) => ChatModelCubit(),),
        BlocProvider(create: (context) => BannersDataCubit()..getCategory()..getBanners(),),
        BlocProvider(create: (context) => HomeScreenCubit()..getUser(),),
        BlocProvider(create: (context) => ProductCoffeeCubit()..getProduct()..getDataUser(),),
        // BlocProvider(create: (context) => FavoriteCubit()..getFavorite(),)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          // home:CacheHelper.getData(key: "idUser")!=null?const HomeCoffee():
          //    const Register()
        home: const SplashScreens(),
        ),


    );
  }
}
