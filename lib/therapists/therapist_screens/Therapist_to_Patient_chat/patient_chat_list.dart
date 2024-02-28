import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:elag/therapists/therapist_screens/Therapist_to_Patient_chat/patient_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/syles.dart';

class PatientsChatListScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  PatientsChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getPatient()
      ..getTherapist()
      ..getUsersData();

    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: SearchBar(
                  constraints: BoxConstraints(
                      minHeight: 40.0,
                      minWidth: MediaQuery.of(context)
                          .size
                          .width // Adjust the height as needed
                      ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search_sharp,
                      color: AppColor.gradientFirst.withOpacity(0.8),
                    ),
                  ),
                  onChanged: (input) {
                    layoutCubit.searchAboutPatient(query: input);
                  },
                ),
              ),
              body: state is GetPatientsLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : layoutCubit.patient.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemCount: layoutCubit.patientsFiltered.isEmpty
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
                                    AppColor.gradientFirst.withOpacity(0.7),
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
                                            return PatientChatScreen(
                                                userModel: layoutCubit
                                                        .patientsFiltered
                                                        .isEmpty
                                                    ? layoutCubit.patient[index]
                                                    : layoutCubit
                                                            .patientsFiltered[
                                                        index]);
                                          },
                                        ),
                                      );
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      layoutCubit.patientsFiltered.isEmpty
                                          ? layoutCubit.patient[index].name!
                                          : layoutCubit
                                              .patientsFiltered[index].name!,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                    leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            layoutCubit.patientsFiltered.isEmpty
                                                ? layoutCubit
                                                    .patient[index].image!
                                                : layoutCubit
                                                    .patientsFiltered[index]
                                                    .image!)),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8),
                                      child: Icon(
                                        Icons.telegram_sharp,
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("you don't have any patients yet..")));
        });
  }
}
