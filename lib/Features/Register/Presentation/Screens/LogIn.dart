import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Core/Helper.dart';
import 'package:food/Features/Register/Data/auth_cubit.dart';
import 'package:food/FeaturesStore/Presentation/HomeCoffe.dart';
import 'package:food/Widget/Custom/CustomButton.dart';
import 'package:food/Widget/Custom/CustomMessage.dart';
import 'package:food/Widget/Custom/CustomTextFormField.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passWordController=TextEditingController();
  GlobalKey<FormState> logInKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SuccessLogIn) {
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
            emailController.clear();
            passWordController.clear();
          } else if (state is ErrorLogIn) {
            AppUsage.message(
                context: context, result: state.error, color: Colors.red);
          } else {
            const CircularProgressIndicator();
          }
        },
        builder: (context, state) {
          var cubit=AuthCubit.get(context);
          return Form(
            key: logInKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(
                    height: MediaQuery.of(context).size.height*.3,
                  ),



                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "LogInScreen",
                        style: GoogleFonts.aladin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
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
                      cubit.changeIcon();
                    },
                    hintText: "passWord",
                    textEditingController: passWordController,
                    isobsecure: cubit.isObscure ? false : true,
                    iconData: cubit.isObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Don't Have Account...!",
                          style: GoogleFonts.aladin(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Register",
                              style: GoogleFonts.aladin(
                                  color: Colors.blue, fontSize: 20),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    textString:state is LoadingLogIn?"Loading...": "LogIn",
                    onPress: () {
                      if (logInKey.currentState!.validate()) {
                        cubit.logIn(
                          email: emailController.text,
                          passWord: passWordController.text,
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
