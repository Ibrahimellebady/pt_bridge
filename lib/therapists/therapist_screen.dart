import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elag/constants/cards.dart';
import 'package:elag/constants/syles.dart';
import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:elag/therapists/therapist_screens/Creat_Exercise/create_exercise.dart';
import 'package:elag/therapists/therapist_screens/Therapist_Home/patients_list_screen.dart';
import 'package:elag/therapists/therapist_screens/Therapist_to_Patient_chat/patient_chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TherapistScreen extends StatefulWidget {
  @override
  State<TherapistScreen> createState() => _TherapistScreenState();
}

class _TherapistScreenState extends State<TherapistScreen> {
  int index = 1;

  final items = const [
    Icon(
      Icons.add_box_rounded,
      color: Colors.white,
    ),
    Icon(
      Icons.home,
      color: Colors.white,
    ),
    Icon(
      Icons.telegram_sharp,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getSelectedWidget2(index: index),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 6),
        child: CurvedNavigationBar(
          items: items,
          index: index,
          onTap: (selectedIndex) {
            setState(() {
              index = selectedIndex;
            });
          },
          // color: Color(0xff542D94),
          color: Color.fromRGBO(23, 31, 166, 0.8235294117647058),
          backgroundColor: Colors.white,
          height: 55,
          animationDuration: Duration(milliseconds: 400),
          animationCurve: Curves.easeInOut,
        ),
      ),
    );
  }

  Widget getSelectedWidget2({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = CreateExercise();
        break;
      case 1:
        widget = PatientsListScreen();
        break;
      case 2:
        widget = PatientsChatListScreen();
        break;
      default:
        widget = PatientsListScreen();
        break;
    }
    return widget;
  }
}

class therapistHome extends StatelessWidget {
  const therapistHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getUsersData()
      ..getUsers();

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  AppColor.gradientFirst.withOpacity(0.9),
                  AppColor.gradientSecond,
                ],
                    begin: const FractionalOffset(0.0, 0.4),
                    end: Alignment.topRight)),
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.8,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      right: 8, top: 8, bottom: 16),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColor.loopColor.withOpacity(0.4),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColor
                                                .secondPageTopIconColor
                                                .withOpacity(0.2),
                                            offset: const Offset(
                                                0, 5), // Set the shadow offset
                                            blurRadius:
                                                10, // Set the shadow blur radius
                                            spreadRadius: 4)
                                      ]),
                                  child: IconButton(
                                      icon: Icon(
                                          Icons
                                              .keyboard_double_arrow_left_sharp,
                                          size: 24,
                                          color: AppColor.secondPageIconColor),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })),
                              // Text(
                              //     "Hello DR ${layoutCubit.userModel!.name!}",
                              //     style: AppDesign.cardName),
                              const SizedBox(height: 5),
                              Text(
                                'we will connect you with your patients and help you choosing exercise program to ensure good results of your treatment',
                                style: AppDesign.cardDescription,
                                maxLines: 2,
                              )
                            ]))),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColor.homePageContainerTextSmall,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50))),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(height: 30),
                        CardDemo(
                            click: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientsListScreen(),
                                ),
                              );
                            },
                            metPath: "assets/images/download.jpg",
                            mainText: 'patient list',
                            descriptionText:
                                'Click here to accept your patients\' requests and control each patient program and re-evaluate your progress'),
                        CardDemo(
                            click: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateExercise()));
                            },
                            metPath: "assets/images/home program.png",
                            mainText: 'Create Exercise',
                            descriptionText:
                                'Click here to create exercise programs to be default ones to make it easily to modificate lately according to each patient'),
                        CardDemo(
                            click: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PatientsChatListScreen()));
                            },
                            metPath: "assets/images/download.jpg",
                            mainText: 'Chat with Doctor',
                            descriptionText: 'Click here to Chat'),
                        // CardDemo(
                        //     click: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 PatientsListSingleScreen()),
                        //       );
                        //     },
                        //     metPath: "assets/images/download.jpg",
                        //     mainText: 'Patients\' List',
                        //     descriptionText:
                        //         'Click here to accept your patients\' requests and control each patient program and re-evaluate your progress'),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
