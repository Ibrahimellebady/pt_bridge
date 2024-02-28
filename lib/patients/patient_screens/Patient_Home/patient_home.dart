import 'package:elag/patients/patient_screens/Patient_Home/Patient_Exercies_list_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/syles.dart';
import '../../../controller/cubit/layout_cubit.dart';
import '../../../view/auth/login.dart';
import 'Therapist_List_Screen.dart';

class Patient_Home extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Patient_Home({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getTherapist()
      ..getRequest()
      ..getRequestData()
      ..getUsersData();
    int n = layoutCubit.RequestFiltered.length;

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (layoutCubit.userModel != null)
                  UserAccountsDrawerHeader(
                      accountName: Text(layoutCubit.userModel!.name!),
                      accountEmail: Text(layoutCubit.userModel!.email!),
                      currentAccountPicture: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(layoutCubit.userModel!.image!))),
                GestureDetector(
                  onTap: () {
                    auth.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        Icon(Icons.logout),
                        SizedBox(
                          width: 6,
                        ),
                        Text("Log out"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          key: scaffoldKey,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff542D94),
                  AppColor.gradientFirst.withOpacity(0.7),
                ],
                begin: const FractionalOffset(0.0, 0.4),
                end: Alignment.centerLeft,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  height: 190,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Hello 👋',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Text(
                        '${layoutCubit.userModel?.name ?? ''}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        height: 80,
                        child: Text(
                          'we will connect you directly with your personal therapist to customize the perfect physical therapy rehabilitation program that will fit your medical condition.',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: 190),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 16, top: 40, right: 16),
                            child: Column(
                              children: [
                                Text(
                                  'Fill your electronic medical sheet to share it easily with your therapist..',
                                  style: TextStyle(
                                      color: Color(0xff542D94),
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Easily chat with therapists to ask and provide updates on your progress..',
                                  style: TextStyle(
                                      color: Color(0xff542D94),
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Start your journey towards recovery and well-being From your home Now!',
                                  style: TextStyle(
                                      color: Color(0xff542D94),
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                layoutCubit.RequestFiltered.isNotEmpty
                    ? ListView.builder(
                        itemCount: n + 1,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height - 280,
                              right: 16,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Patient_Exercies_list_Screen(
                                        userModel: layoutCubit
                                                .therapistsFiltered.isEmpty
                                            ? layoutCubit.therapist[index]
                                            : layoutCubit
                                                .therapistsFiltered[index],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 74,
                                        right: 24,
                                        top: 55,
                                        bottom: 40),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff542D94).withOpacity(0.9),
                                          Color(0xff542D94).withOpacity(0.66),
                                        ],
                                        begin: const FractionalOffset(0.4, 0.8),
                                        end: Alignment.bottomRight,
                                      ),
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    height: 80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 40.0, right: 16),
                                          child: const Text(
                                            'start your program',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 72.0,
                                            right: 16,
                                          ),
                                          child: const Text(
                                            'Now!',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 26,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: -3,
                                    left: 20,
                                    child: SizedBox(
                                      height: 160,
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/male doctor.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height - 280,
                          right: 16,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Therapist_List_Screen();
                                },
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 42, right: 50, top: 50, bottom: 30),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff542D94).withOpacity(0.9),
                                      Color(0xff542D94).withOpacity(0.66),
                                    ],
                                    begin: const FractionalOffset(0.4, 0.8),
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 40.0, left: 8, top: 16),
                                      child: const Text(
                                        'Search for your Doctor Now!',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: -20,
                                child: SizedBox(
                                  height: 170,
                                  child: Hero(
                                    tag: 'find doctor',
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/female doctor.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
