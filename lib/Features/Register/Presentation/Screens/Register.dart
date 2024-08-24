import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Helper.dart';
import 'package:food/Features/HomeScreen/Presentation/Screens/HomeScreen.dart';
import 'package:food/Features/Register/Data/auth_cubit.dart';
import 'package:food/Features/Register/Presentation/Screens/LogIn.dart';
import 'package:food/FeaturesStore/Presentation/HomeCoffe.dart';
import 'package:food/Widget/Custom/CustomButton.dart';
import 'package:food/Widget/Custom/CustomMessage.dart';
import 'package:food/Widget/Custom/CustomTextFormField.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _LogInState();
}

class _LogInState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> keyLogIn = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cubitLogin = AuthCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            AppUsage.message(
                context: context, result: "Success", color: Colors.greenAccent);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeCoffee();
                },
              ),
              (route) => false,
            );
            nameController.clear();
            emailController.clear();
            passWordController.clear();
            cubitLogin.imageFile = null;
          } else if (state is RegisterError) {
            AppUsage.message(
                context: context, result: state.error, color: Colors.red);
          } else {
            const CircularProgressIndicator();
          }
        },
        builder: (context, state) {
          return Form(
            key: keyLogIn,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  cubitLogin.imageFile != null
                      ? CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 80,
                          backgroundImage:
                              FileImage(File(cubitLogin.imageFile!.path)),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 80,
                          backgroundImage:
                              AssetImage("Assets/Images/person2.webp"),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      cubitLogin.selectImage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Select Photo",
                          style: GoogleFonts.aladin(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "RegisterScreen",
                        style: GoogleFonts.aladin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "please enter value ";
                      }
                      return null;
                    },
                    onTap: () {},
                    hintText: "name",
                    textEditingController: nameController,
                    isobsecure: false,
                    iconData: Icons.person,
                  ),
                  CustomTextFormField(
                    helperText: "contain @gmail.com",
                    validate: Helper.validateEmail,
                    onTap: () {},
                    hintText: "email",
                    textEditingController: emailController,
                    isobsecure: false,
                    iconData: Icons.email_rounded,
                  ),
                  CustomTextFormField(
                    helperText:
                        "At least 8 characters, one letter, one number, and one special character",
                    validate: Helper.validatePassword,
                    onTap: () {
                      cubitLogin.changeIcon();
                    },
                    hintText: "passWord",
                    textEditingController: passWordController,
                    isobsecure: cubitLogin.isObscure ? false : true,
                    iconData: cubitLogin.isObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Do you  Have An Account...!",
                          style: GoogleFonts.aladin(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const Login();
                              },));
                            },
                            child: Text(
                              "LogIn",
                              style: GoogleFonts.aladin(
                                  color: Colors.blue, fontSize: 20),
                            ))
                      ],
                    ),
                  ),
                  CustomButton(
                    textString:state is RegisterLoading?"Loading...": "Register",
                    onPress: () {
                      if (keyLogIn.currentState!.validate()) {
                        cubitLogin.register(
                            emailAddress: emailController.text,
                            password: passWordController.text,
                            name: nameController.text,
                            );
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
