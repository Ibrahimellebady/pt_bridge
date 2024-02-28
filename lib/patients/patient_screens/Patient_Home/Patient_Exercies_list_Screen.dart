import 'package:elag/Models/user_model.dart';
import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/syles.dart';
import '../../patient_screen.dart';
import 'detailes_exercise_screen.dart';

class Patient_Exercies_list_Screen extends StatelessWidget {
  final UserModel userModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Patient_Exercies_list_Screen({super.key, required this.userModel});

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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Column(
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
                        Visibility(
                          visible: layoutCubit.requestStatus == "accept" &&
                              cubit.exerciseMessage.isNotEmpty,
                          child: Container(
                            margin: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Text('Your Plan For Today',
                                style: AppDesign.cardName),
                          ),
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
                        : layoutCubit.requestStatus == "accept" &&
                                cubit.exerciseMessage.isNotEmpty
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
                                                MainAxisAlignment.spaceBetween,
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
                                                  margin: const EdgeInsets.only(
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
                                                        margin: const EdgeInsets
                                                            .only(
                                                          top: 8,
                                                        ),
                                                        child: Text(
                                                            cubit
                                                                .exerciseMessage[
                                                                    index]
                                                                .title!,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                          overflow: TextOverflow
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
                            : cubit.exerciseMessage.isEmpty &&
                                    layoutCubit.requestStatus == "accept"
                                ? Message_Widget(
                                    MessageText:
                                        "you don't have any exercises yet..")
                                : layoutCubit.requestStatus == "have doctor"
                                    ? Message_Widget(
                                        MessageText:
                                            "You already are connected to another doctor",
                                      )
                                    : layoutCubit.requestStatus == "pending"
                                        ? Message_Widget(
                                            MessageText:
                                                "Wait for your doctor to accept your request")
                                        : Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                layoutCubit.sendRequestToDoctor(
                                                    doctorID: userModel.id!);

                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          'Your request has been sent to your therapist!'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return PatientsScreen();
                                                            }));
                                                          },
                                                          // PatientsScreen
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: 70,
                                                padding: EdgeInsets.all(4),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    150,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black54),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Send Request",
                                                    style: TextStyle(
                                                      color: Color(0xff6830bb),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                  ),
                ),
                Visibility(
                  visible: layoutCubit.requestStatus == "accept" &&
                      cubit.exerciseMessage.isNotEmpty,
                  child: Container(
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
                                return DetailesExerciseScreen(
                                  exerciseModel: layoutCubit.exrecises.isEmpty
                                      ? layoutCubit.exrecises[0]
                                      : layoutCubit.exrecises[0],
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Start Now!',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
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
