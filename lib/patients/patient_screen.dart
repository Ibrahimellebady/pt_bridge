import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:elag/patients/patient_screens/Patient_Home/patient_home.dart';
import 'package:elag/patients/patient_screens/Patient_Profile/patient_profile.dart';
import 'package:elag/patients/patient_screens/Patient_to_Doctor_chat/Chatting_Therapist_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  State<PatientsScreen> createState() => PatientHomePageState();
}

class PatientHomePageState extends State<PatientsScreen> {
  int index = 1;
  final items = const [
    Icon(
      Icons.person,
      color: Colors.white,
    ),
    Icon(
      Icons.home,
      color: Colors.white,
    ),
    Icon(
      Icons.chat,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getTherapist()
      ..getRequest()
      ..getRequestData()
      ..getUsersData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: getSelectedWidget(index: index, layoutCubit: layoutCubit),
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
          color: Color(0xff542D94),
          backgroundColor: Colors.white,
          height: 55,
          animationDuration: Duration(milliseconds: 400),
          animationCurve: Curves.easeInOut,
        ),
      ),
    );
  }

  Widget getSelectedWidget({required int index, required layoutCubit}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = PatientProfileScreen();
        break;
      case 1:
        widget = Patient_Home();
        break;
      case 2:
        widget = chatting_therapist_list();
        break;
      default:
        widget = Patient_Home();
        break;
    }
    return widget;
  }
}
