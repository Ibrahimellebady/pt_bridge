import 'package:elag/view/auth/cubit/auth_cubit.dart';
import 'package:elag/view/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Therapist_Home/patients_list_screen.dart';

class CreateExercise extends StatelessWidget {
  final exerciseName = TextEditingController();
  final exerciseBody = TextEditingController();
  final exerciseSteps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocProvider.of<AuthCubit>(context).userImgFile != null
                      ? Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .getImage();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  child: Image(
                                    image: FileImage(
                                      BlocProvider.of<AuthCubit>(context)
                                          .userImgFile!,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context).getImage();
                          },
                          child: Container(
                            margin: EdgeInsets.all(
                              16,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 50),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.black45)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image),
                                SizedBox(width: 7),
                                Text("Select Photo"),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 15),
                  CustomTextFormAuth(
                      isNumber: false,
                      valid: (val) {
                        return null;
                      },
                      hintText: "Enter exercise name",
                      labelText: "Exercise Name",
                      iconData: Icons.credit_card_outlined,
                      myController: exerciseName,
                      obscureText: false),
                  CustomTextFormAuth(
                      obscureText: false,
                      isNumber: false,
                      valid: (val) {
                        return null;
                      },
                      hintText: "Enter exercise description",
                      labelText: "Exercise Body",
                      iconData: Icons.short_text_sharp,
                      myController: exerciseBody),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                    child: TextFormField(
                      obscureText: false,
                      validator: (val) {
                        return null;
                      },
                      controller: exerciseSteps,
                      decoration: InputDecoration(
                        hintText: "Enter exercise steps",
                        hintStyle: const TextStyle(fontSize: 14),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        suffixIcon: const Icon(Icons.description_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      if (exerciseName.text.isNotEmpty &&
                          exerciseBody.text.isNotEmpty &&
                          exerciseSteps.text.isNotEmpty) {
                        BlocProvider.of<AuthCubit>(context)
                            .storeExerciseDataToFireStore(
                                exerciseName: exerciseName.text,
                                exerciseBody: exerciseBody.text,
                                exerciseSteps: exerciseSteps.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Please, fill The Textformfield and try again later")));
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
                            "Add Exercise",
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
          );
        },
        listener: (context, state) {
          if (state is FailedToCreateUserState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red, content: Text(state.message)));
          }
          if (state is SaveExerciseDataOnFirestoreSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PatientsListScreen()));
          }
        },
      ),
    );
  }
}
