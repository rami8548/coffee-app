import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Services/LoaclServices.dart';
import 'package:food/Features/Register/Data/auth_cubit.dart';
import 'package:food/Widget/Custom/CustomTextFormField.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            textEditingController: nameController,
            hintText: "Name",
            iconData: Icons.person,
            onTap: () {},
            validate: (p0) {
              if (p0!.isEmpty) {
                return "Please Enter Value";
              }
              return null;
            },
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
if(state is SuccessUpdateDataUser){
  Navigator.pop(context);
}
            },
            builder: (context, state) {
              return MaterialButton(
                color: Colors.teal,

                onPressed: () {
                  AuthCubit.get(context).upDateUserData(
                      CacheHelper.getData(key: "idUser"), nameController.text);
                },
                child: Text("Update"),
              );
            },
          )
        ],
      ),
    );
  }
}
