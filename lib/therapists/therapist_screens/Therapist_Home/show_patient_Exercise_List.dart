import 'package:elag/Models/user_model.dart';
import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:elag/therapists/therapist_screens/Therapist_Home/Share_Exercise.dart';
import 'package:elag/therapists/therapist_screens/Therapist_Home/show_patient_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/syles.dart';

class Show_Patient_Exercies_list_Screen extends StatelessWidget {
  final UserModel userModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Show_Patient_Exercies_list_Screen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context)
      ..getExercise(receiverID: userModel.id!);
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getExreciesData()
      ..getExreciesList()
      ..getRequestValidation(doctorID: userModel.id!);
    return Scaffold(
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is SuccessPatientSendMessageState) {}
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff542D94),
                  Color(0xff542D94).withOpacity(0.75),
                ],
                begin: const FractionalOffset(0.0, 0.4),
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColor.secondPageIconColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ShowPatientProfileScreen(
                                          user: userModel);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 16, bottom: 12),
                                child: Text(
                                  'open Electronic sheet',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 24),
                          child: CircleAvatar(
                              radius: 30,
                              // Add your profile image here
                              backgroundImage: NetworkImage(userModel!.image!)),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Expanded(
                      child: state is GetRequestDataLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : cubit.exerciseMessage.isNotEmpty
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: ListView.builder(
                                    itemCount: cubit.exerciseMessage.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 16),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xff542D94)
                                                        .withOpacity(0.9),
                                                    Color(0xff542D94)
                                                        .withOpacity(0.77),
                                                  ],
                                                  begin: const FractionalOffset(
                                                      0.4, 0.8),
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: AppColor
                                                          .secondPageContainerGradient2ndColor
                                                          .withOpacity(
                                                              0.15), // Set the shadow color
                                                      offset: const Offset(0,
                                                          5), // Set the shadow offset
                                                      blurRadius:
                                                          10, // Set the shadow blur radius
                                                      spreadRadius: 10)
                                                ]),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            height: 110,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 110,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.2,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      // bottomLeft:
                                                      //     Radius.circular(10.0),
                                                      topLeft:
                                                          Radius.circular(15.0),
                                                    ),
                                                    child: Image.network(
                                                        cubit
                                                            .exerciseMessage[
                                                                index]
                                                            .image!,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 16,
                                                      left: 16,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 8,
                                                          ),
                                                          child: Text(
                                                              cubit
                                                                  .exerciseMessage[
                                                                      index]
                                                                  .title!,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 4.0),
                                                          child: Text(
                                                            cubit
                                                                .exerciseMessage[
                                                                    index]
                                                                .steps!,
                                                            style: AppDesign
                                                                .cardDescription,
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : cubit.exerciseMessage.isEmpty
                                  ? Message_Widget(
                                      MessageText:
                                          "your patient don't have any exercises yet..")
                                  : Container()),
                ),
                cubit.exerciseMessage.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.only(
                            bottom: 16, top: 12, left: 52, right: 52),
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          elevation: 5.0,
                          color: Color(0xff6830bb).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TherapistsExercies(
                                        userModel: userModel);
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Edit Program',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(
                            bottom: 16, top: 12, left: 52, right: 52),
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          elevation: 5.0,
                          color: Color(0xff6830bb).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TherapistsExercies(
                                        userModel: userModel);
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Create Program',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Message_Widget extends StatelessWidget {
  final String MessageText;

  Message_Widget({required this.MessageText});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              MessageText,
              style: TextStyle(
                color: Color(0xff6830bb),
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
