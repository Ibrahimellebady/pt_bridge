import 'package:elag/constants/syles.dart';
import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:elag/therapists/therapist_screens/Therapist_Home/show_patient_Exercise_List.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view/auth/login.dart';

class PatientsListScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  PatientsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getPatient()
      ..getTherapist()
      ..getUsersData();

    return BlocConsumer<LayoutCubit, LayoutState>(listener: (context, state) {
      if (state is FilterPatientForUserLoadingState) {
        const CircularProgressIndicator();
      } else if (state is DoctorAcceptPatientLoadingState)
        const CircularProgressIndicator();
      else
        print(state);
    }, builder: (context, state) {
      return Scaffold(
          key: scaffoldKey,
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
          body: state is FilterPatientForUserLoadingState
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: layoutCubit.patientPending.isNotEmpty,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.gradientFirst.withOpacity(0.7),
                                AppColor.gradientSecond,
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                "Patient requests",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                ),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: layoutCubit.patientPending.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 8),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        height: 60,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    layoutCubit
                                                        .patientPending[index]
                                                        .image!)),
                                            const SizedBox(width: 8),
                                            Text(
                                              layoutCubit
                                                  .patientPending[index].name!,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  color: AppColor.gradientFirst
                                                      .withOpacity(0.7)),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  layoutCubit
                                                      .doctorRejectPatient(
                                                          index);
                                                },
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color:
                                                          AppColor.primaryColor,
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.clear,
                                                      color: Colors.white,
                                                    ))),
                                            const SizedBox(width: 16),
                                            InkWell(
                                              onTap: () {
                                                layoutCubit
                                                    .doctorAcceptPatient(index);
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: Colors.green,
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      layoutCubit.patient.isNotEmpty
                          ? Column(
                              children: [
                                Visibility(
                                  visible: layoutCubit.patientPending.isEmpty,
                                  child: SearchBar(
                                    constraints: BoxConstraints(
                                      minHeight:
                                          70.0, // Adjust the height as needed
                                    ),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder?>(
                                      (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        );
                                      },
                                    ),
                                    leading: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.search_sharp,
                                        color: AppColor.gradientFirst
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    onChanged: (input) {
                                      layoutCubit.searchAboutPatient(
                                          query: input);
                                    },
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount:
                                      layoutCubit.patientsFiltered.isEmpty
                                          ? layoutCubit.patient.length
                                          : layoutCubit.patientsFiltered.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 8),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.gradientFirst
                                                .withOpacity(0.7),
                                            AppColor.gradientSecond,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return Show_Patient_Exercies_list_Screen(
                                                        userModel: layoutCubit
                                                                .patientsFiltered
                                                                .isEmpty
                                                            ? layoutCubit
                                                                .patient[index]
                                                            : layoutCubit
                                                                    .patientsFiltered[
                                                                index]);
                                                  },
                                                ),
                                              );
                                            },
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              layoutCubit
                                                      .patientsFiltered.isEmpty
                                                  ? layoutCubit
                                                      .patient[index].name!
                                                  : layoutCubit
                                                      .patientsFiltered[index]
                                                      .name!,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                            ),
                                            leading: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    layoutCubit.patientsFiltered
                                                            .isEmpty
                                                        ? layoutCubit
                                                            .patient[index]
                                                            .image!
                                                        : layoutCubit
                                                            .patientsFiltered[
                                                                index]
                                                            .image!)),
                                            trailing: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0, left: 8),
                                              child: Icon(
                                                Icons.double_arrow_sharp,
                                                color: Colors.white
                                                    .withOpacity(0.75),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 2),
                                child: const Center(
                                  child:
                                      Text("you don't have any patients yet.."),
                                ),
                              ),
                            ),
                    ],
                  ),
                ));
    });
  }
}
