import 'package:elag/constants/images.dart';
import 'package:elag/patients/patient_screen.dart';
import 'package:elag/view/auth/cubit/auth_cubit.dart';
import 'package:elag/view/auth/sign_up.dart';
import 'package:elag/view/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../therapists/therapist_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is TherapistLoginSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TherapistScreen()));
          } else if (state is PatientLoginSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientsScreen()));
          }
          if (state is FailedToLoginState) {}
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.logo,
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(143, 148, 251, 1),
                      Color.fromRGBO(143, 148, 251, .6),
                    ],
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 42),
                  decoration: BoxDecoration(
                    color: Color(0xfffcfcfc),
                    border: Border.all(width: 1, color: Colors.black87),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 12),
                      CustomTextFormAuth(
                          obscureText: false,
                          isNumber: false,
                          valid: (val) {
                            return null;
                          },
                          hintText: "Enter your email",
                          labelText: "Email",
                          iconData: Icons.email_outlined,
                          myController: emailController),
                      CustomTextFormAuth(
                          obscureText: true,
                          isNumber: false,
                          valid: (val) {
                            return null;
                          },
                          hintText: "Enter your password",
                          labelText: "Password",
                          iconData: Icons.lock_outline,
                          myController: passwordController),
                      GestureDetector(
                        onTap: () {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            BlocProvider.of<AuthCubit>(context).login(
                                email: emailController.text,
                                password: passwordController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    "Please, fill your information and try again later"),
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width - 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff6830bb),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 12, bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Don't have an account?"),
                            SizedBox(
                              width: 6,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
