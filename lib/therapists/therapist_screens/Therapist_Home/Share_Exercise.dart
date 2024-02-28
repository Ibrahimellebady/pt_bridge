import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/user_model.dart';
import '../../../constants/syles.dart';
import '../../../controller/cubit/layout_cubit.dart';

// class TherapistsExercies extends StatefulWidget {
//   final UserModel userModel;
//   TherapistsExercies({Key? key, required this.userModel}) : super(key: key);
//   @override
//   State<TherapistsExercies> createState() => _TherapistsExerciesState();
// }
//
// class _TherapistsExerciesState extends State<TherapistsExercies> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     final layoutCubit = BlocProvider.of<LayoutCubit>(context)
//       ..getExreciesData()
//       ..getGaitExreciesList()
//       ..getExreciesList();
//
//     List<String> selectedItems = [];
//     return BlocConsumer<LayoutCubit, LayoutState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final user = layoutCubit.userModel!;
//
//         return DefaultTabController(
//           length: 3, // Define the number of tabs
//           child: Scaffold(
//             appBar: AppBar(
//               leading: GestureDetector(
//                 onTap: () {},
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: CircleAvatar(
//                     backgroundColor: const Color(0xFFfa887a),
//                     radius: 25,
//                     backgroundImage: NetworkImage(user.image ??
//                         'https://firebasestorage.googleapis.com/v0/b/women-health-app-e0660.appspot.com/o/doctor.jpg?alt=media&token=519e9880-17b4-454b-8475-9b7509229291'),
//                   ),
//                 ),
//               ),
//               title: Container(
//                 decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius.circular(20), // Adjust the value as needed
//                   color: Colors.grey.withOpacity(
//                       0.1), // Background color of the TabBar container
//                 ),
//                 child: TabBar(
//                   indicator: ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                           20), // Same as container's borderRadius
//                     ),
//                     color: const Color(0xFFfa887a).withOpacity(
//                         0.4), // Color of the selected tab indicator
//                   ),
//                   indicatorWeight: 1,
//                   indicatorColor:
//                       Colors.red, // Color of the selected tab indicator
//                   dividerColor:
//                       Colors.transparent, // Color of the divider between tabs
//                   labelColor: Colors.black,
//
//                   unselectedLabelColor: Colors.black.withOpacity(
//                       0.7), // Color of the label of unselected tabs
//                   labelStyle: const TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 18), // Style of the label of the selected tab
//                   unselectedLabelStyle: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13), // Style of the label of unselected tabs
//                   labelPadding: const EdgeInsets.symmetric(
//                       horizontal: 0), // Padding around the label of each tab
//                   tabs: [
//                     Container(
//                         decoration: BoxDecoration(
//                           // color: Colors.blue,
//                           borderRadius: BorderRadius.circular(
//                               20), // Adjust the value as needed
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         child: const Tab(text: 'All')),
//                     Container(
//                       decoration: BoxDecoration(
//                         // color: Colors.red,
//                         borderRadius: BorderRadius.circular(
//                             20), // Adjust the value as needed
//                       ),
//                       width: MediaQuery.of(context).size.width,
//                       child: const Tab(
//                         text: 'Patients',
//                       ),
//                     ), // Tab 1 button
//                     Container(
//                         decoration: BoxDecoration(
//                           // color: Colors.blue,
//                           borderRadius: BorderRadius.circular(
//                               20), // Adjust the value as needed
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         child: const Tab(text: 'Doctors')), // Tab 2 button
//                   ],
//                 ),
//               ),
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: layoutCubit.exrecises.length,
//                           itemBuilder: (context, index) {
//                             layoutCubit.exrecises[index];
//                             return GestureDetector(
//                               onTap: () {
//                                 layoutCubit.checkboxIsSelected(
//                                     !layoutCubit.isSelected[index], index);
//                                 selectedItems.clear();
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0, vertical: 12),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: layoutCubit.isSelected[index]
//                                         ? AppColor
//                                             .secondPageContainerGradient2ndColor // Change to your desired color when checked
//                                         : Color(
//                                             0xffdbdade), // Change to your desired color when unchecked
//                                     // color: AppColor
//                                     //     .secondPageContainerGradient2ndColor,
//                                     borderRadius: const BorderRadius.only(
//                                       topRight: Radius.circular(12.0),
//                                       bottomRight: Radius.circular(12.0),
//                                       topLeft: Radius.circular(5.0),
//                                       bottomLeft: Radius.circular(5.0),
//                                     ),
//                                   ),
//                                   width: 125,
//                                   height: 100,
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         height: 100,
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 4,
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(5.0),
//                                             topLeft: Radius.circular(5.0),
//                                           ),
//                                           child: Image.network(
//                                               layoutCubit.usersFiltered.isEmpty
//                                                   ? layoutCubit
//                                                       .exrecises[index].image!
//                                                   : layoutCubit
//                                                       .exrecises[index].image!,
//                                               fit: BoxFit.fill),
//                                         ),
//                                       ),
//                                       Container(
//                                         width:
//                                             MediaQuery.of(context).size.width -
//                                                 170,
//                                         margin: EdgeInsets.only(
//                                             right: 16, left: 16, bottom: 6),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               height: 46,
//                                               margin: const EdgeInsets.only(
//                                                   top: 6, bottom: 4),
//                                               child: Text(
//                                                 layoutCubit
//                                                         .usersFiltered.isEmpty
//                                                     ? layoutCubit
//                                                         .exrecises[index].title!
//                                                     : layoutCubit
//                                                         .exrecises[index]
//                                                         .title!,
//                                                 style: layoutCubit
//                                                         .isSelected[index]
//                                                     ? TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w800,
//                                                         color: Colors.white)
//                                                     : TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                       ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               layoutCubit.usersFiltered.isEmpty
//                                                   ? layoutCubit
//                                                       .exrecises[index].body!
//                                                   : layoutCubit
//                                                       .exrecises[index].body!,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style:
//                                                   layoutCubit.isSelected[index]
//                                                       ? TextStyle(
//                                                           fontStyle:
//                                                               FontStyle.italic,
//                                                           fontWeight:
//                                                               FontWeight.w300,
//                                                           color: Colors.white,
//                                                           fontSize: 13)
//                                                       : TextStyle(
//                                                           fontStyle:
//                                                               FontStyle.italic,
//                                                           fontWeight:
//                                                               FontWeight.w300,
//                                                           fontSize: 13),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20))),
//                         margin: const EdgeInsets.only(
//                             top: 16, left: 8, right: 8, bottom: 16),
//                         child: ListView.separated(
//                           itemCount: layoutCubit.Gaitexrecises.length,
//                           separatorBuilder: (context, index) =>
//                               const SizedBox(height: 8),
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 layoutCubit.checkboxIsSelected(
//                                     !layoutCubit.isSelected[index], index);
//                                 selectedItems.clear();
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0, vertical: 12),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: layoutCubit.isSelected[index]
//                                         ? AppColor
//                                             .secondPageContainerGradient2ndColor // Change to your desired color when checked
//                                         : Color(
//                                             0xffdbdade), // Change to your desired color when unchecked
//                                     // color: AppColor
//                                     //     .secondPageContainerGradient2ndColor,
//                                     borderRadius: const BorderRadius.only(
//                                       topRight: Radius.circular(12.0),
//                                       bottomRight: Radius.circular(12.0),
//                                       topLeft: Radius.circular(5.0),
//                                       bottomLeft: Radius.circular(5.0),
//                                     ),
//                                   ),
//                                   width: 125,
//                                   height: 100,
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         height: 100,
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 4,
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(5.0),
//                                             topLeft: Radius.circular(5.0),
//                                           ),
//                                           child: Image.network(
//                                               layoutCubit
//                                                   .Gaitexrecises[index].image!,
//                                               fit: BoxFit.fill),
//                                         ),
//                                       ),
//                                       Container(
//                                         width:
//                                             MediaQuery.of(context).size.width -
//                                                 170,
//                                         margin: EdgeInsets.only(
//                                             right: 16, left: 16, bottom: 6),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               height: 46,
//                                               margin: const EdgeInsets.only(
//                                                   top: 6, bottom: 4),
//                                               child: Text(
//                                                 layoutCubit.Gaitexrecises[index]
//                                                     .title!,
//                                                 style: layoutCubit
//                                                         .isSelected[index]
//                                                     ? TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w800,
//                                                         color: Colors.white)
//                                                     : TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                       ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               layoutCubit
//                                                   .Gaitexrecises[index].body!,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style:
//                                                   layoutCubit.isSelected[index]
//                                                       ? TextStyle(
//                                                           fontStyle:
//                                                               FontStyle.italic,
//                                                           fontWeight:
//                                                               FontWeight.w300,
//                                                           color: Colors.white,
//                                                           fontSize: 13)
//                                                       : TextStyle(
//                                                           fontStyle:
//                                                               FontStyle.italic,
//                                                           fontWeight:
//                                                               FontWeight.w300,
//                                                           fontSize: 13),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20))),
//                         margin: const EdgeInsets.only(
//                             top: 16, left: 8, right: 8, bottom: 16),
//                         child: ListView.separated(
//                           itemCount: layoutCubit.Gaitexrecises.length,
//                           separatorBuilder: (context, index) =>
//                               const SizedBox(height: 8),
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 layoutCubit.checkboxIsSelected(
//                                     !layoutCubit.isSelected[index], index);
//                                 selectedItems.clear();
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0, vertical: 12),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: layoutCubit.isSelected[index]
//                                         ? AppColor
//                                             .secondPageContainerGradient2ndColor // Change to your desired color when checked
//                                         : Color(
//                                             0xffdbdade), // Change to your desired color when unchecked
//                                     // color: AppColor
//                                     //     .secondPageContainerGradient2ndColor,
//                                     borderRadius: const BorderRadius.only(
//                                       topRight: Radius.circular(12.0),
//                                       bottomRight: Radius.circular(12.0),
//                                       topLeft: Radius.circular(5.0),
//                                       bottomLeft: Radius.circular(5.0),
//                                     ),
//                                   ),
//                                   width: 125,
//                                   height: 100,
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         height: 100,
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 4,
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(5.0),
//                                             topLeft: Radius.circular(5.0),
//                                           ),
//                                           child: Image.network(
//                                               layoutCubit.usersFiltered.isEmpty
//                                                   ? layoutCubit
//                                                       .exrecises[index].image!
//                                                   : layoutCubit
//                                                       .exrecises[index].image!,
//                                               fit: BoxFit.fill),
//                                         ),
//                                       ),
//                                       Container(
//                                         width:
//                                             MediaQuery.of(context).size.width -
//                                                 170,
//                                         margin: EdgeInsets.only(
//                                             right: 16, left: 16, bottom: 6),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               height: 46,
//                                               margin: const EdgeInsets.only(
//                                                   top: 6, bottom: 4),
//                                               child: Text(
//                                                 layoutCubit
//                                                         .usersFiltered.isEmpty
//                                                     ? layoutCubit
//                                                         .exrecises[index].title!
//                                                     : layoutCubit
//                                                         .exrecises[index]
//                                                         .title!,
//                                                 style: layoutCubit
//                                                         .isSelected[index]
//                                                     ? TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w800,
//                                                         color: Colors.white)
//                                                     : TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                       ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                             Text(
//                                               layoutCubit.usersFiltered.isEmpty
//                                                   ? layoutCubit
//                                                       .exrecises[index].body!
//                                                   : layoutCubit
//                                                       .exrecises[index].body!,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style:
//                                                   layoutCubit.isSelected[index]
//                                                       ? TextStyle(
//                                                           fontStyle:
//                                                               FontStyle.italic,
//                                                           fontWeight:
//                                                               FontWeight.w300,
//                                                           color: Colors.white,
//                                                           fontSize: 13)
//                                                       : TextStyle(
//                                                           fontStyle:
//                                                               FontStyle.italic,
//                                                           fontWeight:
//                                                               FontWeight.w300,
//                                                           fontSize: 13),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Add your button functionality here...
//                     },
//                     child: Text('Your Button Text'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class TherapistsExercies extends StatefulWidget {
  final UserModel userModel;
  TherapistsExercies({Key? key, required this.userModel}) : super(key: key);

  @override
  State<TherapistsExercies> createState() => _TherapistsExerciesState();
}

class _TherapistsExerciesState extends State<TherapistsExercies> {
  final ScrollController controller = ScrollController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getExreciesData()
      ..getExreciesList();

    List<String> selectedItems = [];
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              // automaticallyImplyLeading: false,
              // title: SearchBar(
              //   constraints: BoxConstraints(
              //       minHeight: 40.0,
              //       minWidth: MediaQuery.of(context)
              //           .size
              //           .width // Adjust the height as needed
              //       ),
              //   leading: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Icon(
              //       Icons.search_sharp,
              //       color: AppColor.gradientFirst.withOpacity(0.8),
              //     ),
              //   ),
              //   onChanged: (input) {
              //     layoutCubit.searchAboutExercise(query: input);
              //   },
              // ),
              ),
          body: Scaffold(
            body: Column(
              children: [
                Flexible(
                  key: scaffoldKey,
                  child: Scrollbar(
                    interactive: true,
                    controller: controller,
                    thickness: 8,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      controller: controller,
                      itemCount: layoutCubit.exrecises.length,
                      itemBuilder: (context, index) {
                        layoutCubit.exrecises[index];
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              layoutCubit.checkboxIsSelected(
                                  !layoutCubit.isSelected[index], index);
                              selectedItems.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: layoutCubit.isSelected[index]
                                      ? AppColor
                                          .secondPageContainerGradient2ndColor // Change to your desired color when checked
                                      : Color(
                                          0xffdbdade), // Change to your desired color when unchecked
                                  // color: AppColor
                                  //     .secondPageContainerGradient2ndColor,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                  ),
                                ),
                                width: 125,
                                height: 100,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          topLeft: Radius.circular(5.0),
                                        ),
                                        child: Image.network(
                                            layoutCubit.usersFiltered.isEmpty
                                                ? layoutCubit
                                                    .exrecises[index].image!
                                                : layoutCubit
                                                    .exrecises[index].image!,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          170,
                                      margin: EdgeInsets.only(
                                          right: 16, left: 16, bottom: 6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 46,
                                            margin: const EdgeInsets.only(
                                                top: 6, bottom: 4),
                                            child: Text(
                                              layoutCubit.usersFiltered.isEmpty
                                                  ? layoutCubit
                                                      .exrecises[index].title!
                                                  : layoutCubit
                                                      .exrecises[index].title!,
                                              style:
                                                  layoutCubit.isSelected[index]
                                                      ? TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: Colors.white)
                                                      : TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            layoutCubit.usersFiltered.isEmpty
                                                ? layoutCubit
                                                    .exrecises[index].body!
                                                : layoutCubit
                                                    .exrecises[index].body!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: layoutCubit.isSelected[index]
                                                ? TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontSize: 13)
                                                : TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 52, vertical: 24),
                  child: TextButton(
                    onPressed: () async {
                      await layoutCubit
                          .deleteExerciseCollection(widget.userModel.id!)
                          .then(
                        (value) {
                          for (int i = 0;
                              i < layoutCubit.exrecises.length;
                              i++) {
                            if (layoutCubit.isSelected[i] == true) {
                              print("addd");
                              layoutCubit.sendExercise(
                                index: i,
                                title: layoutCubit.exrecises[i].title!,
                                receiverID: widget.userModel.id!,
                                body: layoutCubit.exrecises[i].body!,
                                image: layoutCubit.exrecises[i].image!,
                                steps: layoutCubit.exrecises[i].steps!,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Exercises have been sent to your patient!'),
                                  duration: Duration(seconds: 2),
                                  width:
                                      300, // Adjust the width based on your design
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.mainBlue),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 20),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text('Share Now',
                        style: TextStyles.font16WhiteSemiBold),
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
