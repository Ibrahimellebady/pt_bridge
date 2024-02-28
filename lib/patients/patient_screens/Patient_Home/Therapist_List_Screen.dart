import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Patient_Exercies_list_Screen.dart';

class Therapist_List_Screen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  Therapist_List_Screen({super.key});
  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getTherapist()
      ..getUsersData();

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: Scaffold(
            key: scaffoldKey,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff542D94).withOpacity(0.9),
                    Color(0xff542D94).withOpacity(0.7),
                  ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff542D94).withOpacity(0.6),
                          Color(0xff542D94).withOpacity(0.2),
                        ],
                        begin: const FractionalOffset(0.0, 0.4),
                        end: Alignment.bottomRight,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Stack(
                      children: [
                        Positioned(
                          right: -12,
                          child: Container(
                            height: 250,
                            padding: const EdgeInsets.only(
                              top: 16,
                            ),
                            child: Hero(
                              tag: 'find doctor',
                              child: Image.asset(
                                  'assets/images/female doctor.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                height: 40,
                                margin: const EdgeInsets.only(
                                    left: 16, top: 40, right: 16),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16, bottom: 2),
                                        child: TextField(
                                          controller: _searchController,
                                          onChanged: (query) {
                                            if (query.isNotEmpty) {
                                              layoutCubit.searchAboutTherapists(
                                                  query: query);
                                            } else {}
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 8,
                                      right: 16,
                                      child: Icon(
                                        Icons.search_sharp,
                                        color: Color(0xff542D94),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 16, top: 16),
                                child: Text(
                                  'Find Your Doctor',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  'Now!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 32,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  state is GetTherabistsLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : layoutCubit.therapist.isNotEmpty
                          ? Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              margin: const EdgeInsets.only(
                                  top: 225, left: 8, right: 8),
                              child: ListView.separated(
                                itemCount:
                                    layoutCubit.therapistsFiltered.isEmpty
                                        ? layoutCubit.therapist.length
                                        : layoutCubit.therapistsFiltered.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Patient_Exercies_list_Screen(
                                            userModel: layoutCubit
                                                    .therapistsFiltered.isEmpty
                                                ? layoutCubit.therapist[index]
                                                : layoutCubit
                                                    .therapistsFiltered[index]);
                                      }));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 6),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff542D94).withOpacity(0.9),
                                            Color(0xff542D94).withOpacity(0.66),
                                          ],
                                          begin:
                                              const FractionalOffset(0.4, 0.8),
                                          end: Alignment.bottomRight,
                                        ),
                                        border:
                                            Border.all(color: Colors.black54),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      height: 70,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    layoutCubit
                                                            .therapistsFiltered
                                                            .isEmpty
                                                        ? layoutCubit
                                                            .therapist[index]
                                                            .image!
                                                        : layoutCubit
                                                            .therapistsFiltered[
                                                                index]
                                                            .image!)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      166,
                                                  child: Text(
                                                    layoutCubit
                                                            .therapistsFiltered
                                                            .isEmpty
                                                        ? "Dr. ${layoutCubit.therapist[index].name!}"
                                                        : "Dr. ${layoutCubit.therapistsFiltered[index].name!}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 22),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      166,
                                                  child: Text(
                                                    layoutCubit
                                                            .therapistsFiltered
                                                            .isEmpty
                                                        ? "${layoutCubit.therapist[index].doctorDiscription ?? 'Job title is not available yet..'}"
                                                        : "${layoutCubit.therapistsFiltered[index].doctorDiscription ?? 'Job title is not available yet..'}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                              Icons.keyboard_double_arrow_right,
                                              color: Colors.white
                                                  .withOpacity(0.77)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text(""),
                            ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
