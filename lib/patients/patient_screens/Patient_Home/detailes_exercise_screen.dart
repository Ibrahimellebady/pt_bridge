import 'package:elag/Models/exrecies_model.dart';
import 'package:elag/controller/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/syles.dart';

class DetailesExerciseScreen extends StatefulWidget {
  final ExerciseModel exerciseModel;

  DetailesExerciseScreen({super.key, required this.exerciseModel});

  @override
  State<DetailesExerciseScreen> createState() => _DetailesExerciseScreenState();
}

class _DetailesExerciseScreenState extends State<DetailesExerciseScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void goToNextExercise() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getExreciesList();

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: PageView.builder(
            controller: _pageController,
            itemCount: layoutCubit.exerciseMessage.length +
                1, // Add one for the final screen
            itemBuilder: (context, index) {
              if (index == layoutCubit.exerciseMessage.length) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Image.asset(
                          'assets/images/success-work.jpg',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(60),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff6830bb),
                            ),
                            child: Center(
                              child: Text(
                                "Go Back",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      "You have finished your exercise for today",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                );
              } else {
                // Display the exercise details
                return _buildExerciseScreen(context, layoutCubit, index);
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              goToNextExercise();
            },
            child: Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }

  Widget _buildExerciseScreen(
      BuildContext context, LayoutCubit layoutCubit, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff542D94),
            Color(0xff542D94).withOpacity(0.77),
          ],
          begin: const FractionalOffset(0.4, 0.8),
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.network(
                  layoutCubit.exerciseMessage[index].image!,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(width: 2, color: Colors.black),
                    ),
                  ),
                  child: LinearProgressIndicator(
                    value: (index + 0.8) / layoutCubit.exerciseMessage.length,
                    backgroundColor: Colors.white
                        .withOpacity(0.8), // Customize the background color
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xff542D94)), // Customize the progress bar color
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              "${index + 1}. ${layoutCubit.exerciseMessage[index].title!}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: TextDecoration.none),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor.homePageContainerTextSmall,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...layoutCubit.exerciseMessage[index].steps!
                        .split('||')
                        .map((step) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '$step',
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.none,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
