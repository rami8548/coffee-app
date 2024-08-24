import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Register/Presentation/Screens/Register.dart';
import 'package:food/FeaturesStore/Data/ProductCofee/product_coffee_cubit.dart';
import 'package:food/FeaturesStore/Presentation/Profile/Widget/Privacy.dart';
import 'package:food/FeaturesStore/Presentation/Profile/Widget/UpDateProfile.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    ProductCoffeeCubit.get(context).getDataUser();
    var cubit = ProductCoffeeCubit.get(context)
      ..getFavorite(CacheHelper.getData(key: "idUser"));

    return BlocConsumer<ProductCoffeeCubit, ProductCoffeeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      cubit.userModel!.url,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateProfile();
                                  },
                                ));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ))),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  cubit.userModel!.name,
                  style: GoogleFonts.aladin(fontSize: 20),
                ),
                Text(
                  cubit.userModel!.email,
                  style:
                      GoogleFonts.aladin(fontSize: 20, color: Colors.blueGrey),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            button("Theme", () {}, Icons.dark_mode),
            const SizedBox(
              height: 30,
            ),
            button("privacy", () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Privacy();
                },
              ));
            }, Icons.privacy_tip_outlined),
            const SizedBox(
              height: 30,
            ),
            button("LogOut", () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Register();
                  },
                ),
                (route) => false,
              );
              CacheHelper.removeData(key: "idUser");
            }, Icons.login_outlined),
            const SizedBox(
              height: 30,
            ),
          ],
        );
      },
    );
  }

  Widget button(String text, void Function()? fun, IconData icon) {
    return MaterialButton(
      onPressed: fun,
      color: Colors.black26,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: GoogleFonts.aladin(fontSize: 20),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
