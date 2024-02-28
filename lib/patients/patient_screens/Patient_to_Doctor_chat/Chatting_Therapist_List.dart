import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../therapists/therapist_screens/Therapist_to_Patient_chat/patient_chat_screen.dart';

class chatting_therapist_list extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  chatting_therapist_list({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
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
                      color: Color(0xff6830bb),
                    ),
                  ),
                  onChanged: (input) {
                    layoutCubit.searchAboutTherapists(query: input);
                  },
                ),
              ),
              body: state is GetTherabistsLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : layoutCubit.therapist.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          child: ListView.separated(
                              itemCount: layoutCubit.therapistsFiltered.isEmpty
                                  ? layoutCubit.therapist.length
                                  : layoutCubit.therapistsFiltered.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff542D94).withOpacity(0.9),
                                        Color(0xff542D94).withOpacity(0.7),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.4),
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PatientChatScreen(
                                                userModel: layoutCubit
                                                        .therapistsFiltered
                                                        .isEmpty
                                                    ? layoutCubit
                                                        .therapist[index]
                                                    : layoutCubit
                                                            .therapistsFiltered[
                                                        index]);
                                          },
                                        ),
                                      );
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    leading: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                              layoutCubit.therapistsFiltered
                                                      .isEmpty
                                                  ? layoutCubit
                                                      .therapist[index].image!
                                                  : layoutCubit
                                                      .therapistsFiltered[index]
                                                      .image!)),
                                    ),
                                    title: Text(
                                      layoutCubit.therapistsFiltered.isEmpty
                                          ? layoutCubit.therapist[index].name!
                                          : layoutCubit
                                              .therapistsFiltered[index].name!,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8),
                                      child: Icon(
                                        Icons.telegram_sharp,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    subtitle: Container(
                                      width: MediaQuery.of(context).size.width -
                                          166,
                                      child: Text(
                                        layoutCubit.therapistsFiltered.isEmpty
                                            ? "${layoutCubit.therapist[index].doctorDiscription ?? 'Job title is not available yet..'}"
                                            : "${layoutCubit.therapistsFiltered[index].doctorDiscription ?? 'Job title is not available yet..'}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                );
                              }))
                      : const Center(
                          child: Text("There is no Therapists yet")));
        });
  }
}
