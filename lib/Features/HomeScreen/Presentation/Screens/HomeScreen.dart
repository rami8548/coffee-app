import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Features/Chat/Presentation/Screens/ChatScreens.dart';
import 'package:food/F'
    'eatures/HomeScreen/Data/home_screen_cubit.dart';
import 'package:food/Features/Register/Model/UserModel.dart';
import 'package:food/Features/Register/Presentation/Screens/Register.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Text("Chat"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  // HomeScreenCubit.get(context).logOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Register();
                      },
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout)),
          )
        ],
      ),
      body: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubitHomeScreen = HomeScreenCubit.get(context);

          return ListView(
            shrinkWrap: true,
            children: [
              searchName(
                (query) {
                  cubitHomeScreen.searchUser(query);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 30,
                  );
                },
                shrinkWrap: true,
                itemCount: cubitHomeScreen.getSearch.isEmpty
                    ? cubitHomeScreen.getAllUser.length
                    : cubitHomeScreen.getSearch.length,
                itemBuilder: (context, index) {
                  return showHome(
                    cubitHomeScreen.getSearch.isEmpty
                        ? cubitHomeScreen.getAllUser[index]
                        : cubitHomeScreen.getSearch[index],
                    context,
                    () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ChatScreens(
                            userModel: cubitHomeScreen.getSearch.isEmpty
                                ? cubitHomeScreen.getAllUser[index]
                                : cubitHomeScreen.getSearch[index],
                          );
                        },
                      ));
                    },
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget showHome(
      UserModel userModel, BuildContext context, void Function()? onPress) {
    return GestureDetector(
      onTap: onPress,
      child: ListTile(
        title: Text(userModel.name, style: GoogleFonts.aladin(fontSize: 20)),
        leading: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(userModel.url),
                              fit: BoxFit.fill)),
                    ),
                  ],
                );
              },
            );
          },
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(userModel.url),
          ),
        ),
      ),
    );
  }

  Widget searchName(void Function(String)? onchange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onchange,
        decoration: InputDecoration(
          labelText: "search",
          suffixIcon: const Icon(Icons.search),
          labelStyle: GoogleFonts.aladin(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.indigo),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.indigo),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
