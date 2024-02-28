import 'package:elag/patients/patient_screen.dart';
import 'package:elag/view/auth/cubit/auth_cubit.dart';
import 'package:elag/view/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../therapists/therapist_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final DoctorJobTitleController = TextEditingController();

  // final chooseController = TextEditingController();
  String? chooseController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocProvider.of<AuthCubit>(context).userImgFile != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .getImage();
                                },
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        50), // Set your desired border radius here
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          BlocProvider.of<AuthCubit>(context)
                                              .userImgFile!),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .getImage();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      border: Border.all(color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 24, top: 8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Add profile picture",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    CustomTextFormAuth(
                        isNumber: false,
                        valid: (val) {
                          return null;
                        },
                        hintText: "Enter Your Username",
                        labelText: "Username",
                        iconData: Icons.person_outlined,
                        myController: nameController,
                        obscureText: false),
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
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      padding: EdgeInsets.only(left: 16),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        border: Border.all(color: Colors.black87),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        value: chooseController,
                        hint: Text('Select Status'),
                        onChanged: (value) {
                          setState(
                            () {
                              chooseController = value;
                            },
                          );
                        },
                        items: ['Patient', 'Therapist']
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  // style: TextStyle(fontSize: 12),
                                ),
                              ),
                            )
                            .toList(),
                        underline: SizedBox.shrink(), // Remove underline
                        icon: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width - 235,
                          ),
                          child: Icon(Icons.arrow_drop_down),
                        ), // Icon at the end
                        iconSize: 32, // Adjust icon size as needed
                      ),
                    ),
                    Visibility(
                      visible: chooseController == 'Therapist',
                      child: CustomTextFormAuth(
                        obscureText: false,
                        isNumber: false,
                        valid: (val) {
                          return null;
                        },
                        hintText: "Enter your job title",
                        labelText: "Job Title",
                        iconData: Icons.work_outline_sharp,
                        myController: DoctorJobTitleController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          BlocProvider.of<AuthCubit>(context).register(
                              choose: chooseController.toString(),
                              email: emailController.text,
                              name: nameController.text,
                              password: passwordController.text,
                              doctorDiscription: DoctorJobTitleController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  "Please, fill your information first and try again")));
                        }
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 16, bottom: 8),
                          padding: EdgeInsets.all(4),
                          width: MediaQuery.of(context).size.width - 160,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff6830bb),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up Now!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is FailedToCreateUserState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red, content: Text(state.message)));
          }
          if (state is PatientCreatedSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientsScreen()));
          }
          if (state is TherabistCreatedSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TherapistScreen()));
          }
        },
      ),
    );
  }
}
