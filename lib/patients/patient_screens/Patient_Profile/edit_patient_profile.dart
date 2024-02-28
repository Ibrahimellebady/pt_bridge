import 'package:elag/Models/user_model.dart';
import 'package:elag/constants/syles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../controller/cubit/layout_cubit.dart';
import '../../patient_screen.dart';

class EditPatientScreen extends StatefulWidget {
  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  String? emailx;
  String? namex;
  String? imagex;
  String? idx;
  int? aging;
  int heightx = 0;
  int weightx = 0;
  final TextEditingController _AgeController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  bool? isSmoking;
  bool? isAlcoholic;
  bool? isActive;

  //
  int? patientheight;
  int? patienWeight;
  int? patienPain;

  bool? patientSmoking;
  bool? patientalcholic;
  bool? patientActive;

  // Present Health Information

  final TextEditingController _chiefComplainController =
      TextEditingController();
  final TextEditingController _onsetController = TextEditingController();
  final TextEditingController _durationOfSymptomsController =
      TextEditingController();
  final TextEditingController _courseOfDiseaseController =
      TextEditingController();
  final TextEditingController _MedicationsController = TextEditingController();
  int? painScaleLevel = 0;

  // Past Medical History
  final TextEditingController _chronicDiseasesController =
      TextEditingController();
  final TextEditingController _pastInjuriesController = TextEditingController();
  final TextEditingController _pastSurgeriesController =
      TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _immunizationController = TextEditingController();

  bool? patientFamilyHeartDisease;
  bool? patientFamilyStroke;
  bool? patientFamilyCancer;
  bool? patientFamilyDiabetes;
  bool? patientFamilyHighBloodPressure;
  bool? patientFamilyObesity;
  bool? patientFamilyAlzheimer;
  bool? patientFamilyKidneyDisease;
  bool? patientFamilyLiverDisease;

  bool? patientFamilyHeartDiseasex;
  bool? patientFamilyStrokex;
  bool? patientFamilyCancerx;
  bool? patientFamilyDiabetesx;
  bool? patientFamilyHighBloodPressurex;
  bool? patientFamilyObesityx;
  bool? patientFamilyAlzheimerx;
  bool? patientFamilyKidneyDiseasex;
  bool? patientFamilyLiverDiseasex;

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)..getUsersData();

    return Scaffold(
      body: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          final user = layoutCubit.userModel!;
          idx = user.id;
          imagex = user.image!;
          emailx = user.email!;
          namex = user.name!;
          _addressController.text = user.patientAdress ?? '';
          _AgeController.text = user.patientAge.toString();
          _phoneNumberController.text = user.phoneNumber ?? '';
          _occupationController.text = user.patientOccupation ?? '';
          _maritalStatusController.text = user.maritalStatus ?? '';
          _sexController.text = user.sex ?? '';

          _chiefComplainController.text = user.patientComplain ?? '';
          _courseOfDiseaseController.text = user.patientCourse ?? '';
          _onsetController.text = user.patientOnset ?? '';
          _durationOfSymptomsController.text = user.patientDuration ?? '';
          _MedicationsController.text = user.patientMedication ?? '';
          _chronicDiseasesController.text = user.patientChronicDiseases ?? '';
          _pastInjuriesController.text = user.patientPastInjuries ?? '';
          _pastSurgeriesController.text = user.patientPastSurgeries ?? '';
          _allergiesController.text = user.patientAllergies ?? '';
          _immunizationController.text = user.patientImmunization ?? '';

          //
          patientheight = user.patientHeight;
          patienWeight = user.patientWeight;
          patienPain = user.patientPainLevel;

          patientSmoking = user.isPatientSmoking;
          patientalcholic = user.isPatientAlcoholic;
          patientActive = user.isPatientActive;

          //
          patientFamilyHeartDiseasex = user.patientFamilyHeartDisease;
          patientFamilyStrokex = user.patientFamilyStroke;
          patientFamilyCancerx = user.patientFamilyCancer;
          patientFamilyDiabetesx = user.patientFamilyDiabetes;
          patientFamilyHighBloodPressurex = user.patientFamilyHighBloodPressure;
          patientFamilyObesityx = user.patientFamilyObesity;
          patientFamilyAlzheimerx = user.patientFamilyAlzheimer;
          patientFamilyKidneyDiseasex = user.patientFamilyKidneyDisease;
          patientFamilyLiverDiseasex = user.patientFamilyLiverDisease;

          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                leading: Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20), // Adjust the value as needed
                    color: Colors.grey.withOpacity(
                        0.2), // Background color of the TabBar container
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      isScrollable: true,

                      indicator: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Same as container's borderRadius
                        ),
                        color: const Color(0xff542D94).withOpacity(
                            0.8), // Color of the selected tab indicator
                      ),
                      indicatorWeight: 1,
                      indicatorColor:
                          Colors.red, // Color of the selected tab indicator
                      dividerColor: Colors
                          .transparent, // Color of the divider between tabs
                      labelColor: Colors.white,

                      unselectedLabelColor: Colors.black.withOpacity(0.7),

                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors
                              .white), // Style of the label of the selected tab
                      unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize:
                              13), // Style of the label of unselected tabs

                      tabs: [
                        Tap_Widget(
                          TapName: 'Personal History',
                        ),
                        Tap_Widget(
                          TapName: 'Present History',
                        ),
                        Tap_Widget(
                          TapName: 'Past History',
                        ),
                        Tap_Widget(
                          TapName: 'Family History',
                        ),

                        // Tab 2 button
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  Personal_History_Widget(context, user),
                  Present_History_Widget(context),
                  Past_History_Widget(context),
                  Family_History_Widget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView Family_History_Widget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Image.asset('name'),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ), // Adjust the value as needed
              side: BorderSide(
                  width: 2,
                  color: Colors.black.withOpacity(
                      0.7)), // Add this line to maintain the border
            ),
            margin: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyHeartDisease = value;
                        });
                      },
                      question:
                          'Does any one of your family have Heart Disease?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyObesity = value;
                        });
                      },
                      question: 'Does any one of your family have Obesity?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyHighBloodPressure = value;
                        });
                      },
                      question:
                          'Does any one of your family have high blood pressure?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyLiverDisease = value;
                        });
                      },
                      question:
                          'Does any one of your family have Liver Disease?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyKidneyDisease = value;
                        });
                      },
                      question:
                          'Does any one of your family have Kidney Disease?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyDiabetes = value;
                        });
                      },
                      question: 'Does any one of your family have Diabetes?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyCancer = value;
                        });
                      },
                      question: 'Does any one of your family have Cancer?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyAlzheimer = value;
                        });
                      },
                      question:
                          'Does any one of your family have Alzheimer\s?'),
                  boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          patientFamilyStroke = value;
                        });
                      },
                      question: 'Does any one of your family have Stroke?'),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 50),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: () {
                _update4(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientsScreen(),
                  ),
                );
              },
              color: const Color.fromRGBO(143, 148, 251, 1),
              textColor: Colors.white,
              child: Text(
                "Update Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView Past_History_Widget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Image.asset('name'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ), // Adjust the value as needed
                side: BorderSide(
                    width: 2,
                    color: Colors.black.withOpacity(
                        0.7)), // Add this line to maintain the border
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Chronic Diseases',
                      controller: _chronicDiseasesController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Past Injuries',
                      controller: _pastInjuriesController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Past Surgeries',
                      controller: _pastSurgeriesController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Allergies',
                      controller: _allergiesController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Immunization',
                      controller: _immunizationController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 50),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: () {
                _update3(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientsScreen(),
                  ),
                );
              },
              color: const Color.fromRGBO(143, 148, 251, 1),
              textColor: Colors.white,
              child: Text(
                "Update Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _update3
  SingleChildScrollView Present_History_Widget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Image.asset('name'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ), // Adjust the value as needed
                side: BorderSide(
                    width: 2,
                    color: Colors.black.withOpacity(
                        0.7)), // Add this line to maintain the border
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Pain_Scale_widget(context),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'chief Complain',
                      controller: _chiefComplainController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Onset',
                      controller: _onsetController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Course',
                      controller: _courseOfDiseaseController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Duration',
                      controller: _durationOfSymptomsController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Medication',
                      controller: _MedicationsController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 50),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: () {
                _update2(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientsScreen(),
                  ),
                );
              },
              color: const Color.fromRGBO(143, 148, 251, 1),
              textColor: Colors.white,
              child: Text(
                "Update Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView Personal_History_Widget(
      BuildContext context, UserModel user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Image.asset('name'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ), // Adjust the value as needed
                side: BorderSide(
                    width: 2,
                    color: Colors.black.withOpacity(
                        0.7)), // Add this line to maintain the border
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Visibility(
                      visible: user.patientAge == null,
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black87),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectedDate == null
                                  ? const Text('Enter your Birth day')
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat.yMMMd()
                                              .format(selectedDate!),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              266,
                                        ),
                                        Text(
                                          "${aging.toString()} years",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                              const Icon(
                                Icons.date_range,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    height_widget(context),
                    weight_widget(context),
                    SizedBox(
                      height: 16,
                    ),
                    boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          isSmoking = value;
                        });
                      },
                      question: 'Do you smoke?',
                    ),
                    boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          isAlcoholic = value;
                        });
                      },
                      question: 'Do you Drink alcohol?',
                    ),
                    boolenQuestion(
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                      question: 'Do you do exercises?',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Address',
                      controller: _addressController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'phone',
                      controller: _phoneNumberController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Occupation',
                      controller: _occupationController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Marital Status',
                      controller: _maritalStatusController,
                    ),
                    textField(
                      fieldWidth: MediaQuery.of(context).size.width,
                      fieldName: 'Sex',
                      controller: _sexController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 50),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: () {
                _update1(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientsScreen(),
                  ),
                );
              },
              color: const Color.fromRGBO(143, 148, 251, 1),
              textColor: Colors.white,
              child: Text(
                "Update Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container weight_widget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black26.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(width: 2, color: Colors.black)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weight',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      weightx == 0 ? '' : weightx.toString(),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 2),
                      child: Text('Kg'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xffC123D3),
                inactiveTrackColor: Colors.black45,
                thumbColor: const Color(0xffAD23D3),
                overlayColor: const Color(0x29EB1555),
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 10.0),
              ),
              child: Slider(
                value: weightx.toDouble(),
                min: 0,
                max: 200,
                onChanged: (double newValue) {
                  setState(() {
                    weightx = newValue.round();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container height_widget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black26.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(width: 2, color: Colors.black)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Height',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      heightx == 0 ? '' : heightx.toString(),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 2),
                      child: Text('cm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xffC123D3),
                inactiveTrackColor: Colors.black45,
                thumbColor: const Color(0xffAD23D3),
                overlayColor: const Color(0x29EB1555),
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 10.0),
              ),
              child: Slider(
                value: heightx.toDouble(),
                min: 0,
                max: 220,
                onChanged: (double newValue) {
                  setState(() {
                    heightx = newValue.round();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container Pain_Scale_widget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black26.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(width: 2, color: Colors.black)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pain Scale level',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  painScaleLevel == 0 ? '' : painScaleLevel.toString(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Container(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xffC123D3),
                inactiveTrackColor: Colors.black45,
                thumbColor: const Color(0xffAD23D3),
                overlayColor: const Color(0x29EB1555),
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 10.0),
              ),
              child: Slider(
                value: painScaleLevel!.toDouble(),
                min: 0,
                max: 10,
                onChanged: (double newValue) {
                  setState(() {
                    painScaleLevel = newValue.round();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _update(BuildContext context) {
  //   String id = idx!;
  //   String name = namex!;
  //   String image = imagex!;
  //   String email = emailx!;
  //   String address = _addressController.text.trim();
  //   String phoneNumber = _phoneNumberController.text.trim();
  //   String patientOccupation = _occupationController.text.trim();
  //   String maritalStatus = _maritalStatusController.text.trim();
  //   int? age = aging?.toInt() ?? int.parse(_AgeController.text);
  //   int? height = heightx;
  //   int? weight = weightx;
  //   bool? isPatientSmoking = isSmoking;
  //   bool? isPatientAlcoholic = isAlcoholic;
  //   bool? isPatientActive = isActive;
  //
  //   String patientComplain = _chiefComplainController.text.trim();
  //   String patientOnset = _onsetController.text.trim();
  //   String patientCourse = _courseOfDiseaseController.text.trim();
  //   String patientDuration = _durationOfSymptomsController.text.trim();
  //   String patientMedication = _MedicationsController.text.trim();
  //   int? patientPainLevel = painScaleLevel;
  //
  //   String patientChronicDiseases = _chronicDiseasesController.text.trim();
  //   String patientPastInjuries = _pastInjuriesController.text.trim();
  //   String patientPastSurgeries = _pastSurgeriesController.text.trim();
  //   String patientAllergies = _allergiesController.text.trim();
  //   String patientImmunization = _immunizationController.text.trim();
  //   // Call the updatePatientDataToFireStore method from your Cubit
  //   context.read<LayoutCubit>().sendPatientDataToFireStore2(
  //         patientID: id,
  //         patientUrl: image,
  //         patientName: name,
  //         patientEmail: email,
  //         chooseStatus: 'Patient',
  //         patientAge: age,
  //         patientAdress: address,
  //         patientHeight: height,
  //         patientWeight: weight,
  //         phoneNumber: phoneNumber,
  //         patientOccupation: patientOccupation,
  //         maritalStatus: maritalStatus,
  //         isPatientSmoking: isPatientSmoking,
  //         isPatientAlcoholic: isPatientAlcoholic,
  //         isPatientActive: isPatientActive,
  //         patientComplain: patientComplain,
  //         patientOnset: patientOnset,
  //         patientCourse: patientCourse,
  //         patientDuration: patientDuration,
  //         patientMedication: patientMedication,
  //         patientPainLevel: patientPainLevel,
  //         patientChronicDiseases: patientChronicDiseases,
  //         patientPastInjuries: patientPastInjuries,
  //         patientPastSurgeries: patientPastSurgeries,
  //         patientAllergies: patientAllergies,
  //         patientImmunization: patientImmunization,
  //         patientFamilyAlzheimer: patientFamilyAlzheimer,
  //         patientFamilyCancer: patientFamilyCancer,
  //         patientFamilyDiabetes: patientFamilyDiabetes,
  //         patientFamilyHeartDisease: patientFamilyHeartDisease,
  //         patientFamilyHighBloodPressure: patientFamilyHighBloodPressure,
  //         patientFamilyKidneyDisease: patientFamilyKidneyDisease,
  //         patientFamilyLiverDisease: patientFamilyLiverDisease,
  //         patientFamilyObesity: patientFamilyObesity,
  //         patientFamilyStroke: patientFamilyStroke,
  //       );
  // }

  void _update1(BuildContext context) {
    String id = idx!;
    String name = namex!;
    String image = imagex!;
    String email = emailx!;
    String address = _addressController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String patientOccupation = _occupationController.text.trim();
    String maritalStatus = _maritalStatusController.text.trim();
    String sex = _sexController.text.trim();

    int? age = aging?.toInt() ?? int.parse(_AgeController.text);
    int? height = heightx;
    int? weight = weightx;
    bool? isPatientSmoking = isSmoking;
    bool? isPatientAlcoholic = isAlcoholic;
    bool? isPatientActive = isActive;

    String patientComplain = _chiefComplainController.text.trim();
    String patientOnset = _onsetController.text.trim();
    String patientCourse = _courseOfDiseaseController.text.trim();
    String patientDuration = _durationOfSymptomsController.text.trim();
    String patientMedication = _MedicationsController.text.trim();
    int? patientPainLevel = patienPain;

    String patientChronicDiseases = _chronicDiseasesController.text.trim();
    String patientPastInjuries = _pastInjuriesController.text.trim();
    String patientPastSurgeries = _pastSurgeriesController.text.trim();
    String patientAllergies = _allergiesController.text.trim();
    String patientImmunization = _immunizationController.text.trim();

    bool? patientFamilyAlzheimer = patientFamilyAlzheimerx;
    bool? patientFamilyCancer = patientFamilyCancerx;
    bool? patientFamilyDiabetes = patientFamilyDiabetesx;
    bool? patientFamilyHeartDisease = patientFamilyHeartDiseasex;
    bool? patientFamilyHighBloodPressure = patientFamilyHighBloodPressurex;
    bool? patientFamilyKidneyDisease = patientFamilyKidneyDiseasex;
    bool? patientFamilyLiverDisease = patientFamilyLiverDiseasex;
    bool? patientFamilyObesity = patientFamilyObesityx;
    bool? patientFamilyStroke = patientFamilyStrokex;

    // Call the updatePatientDataToFireStore method from your Cubit
    context.read<LayoutCubit>().sendPatientDataToFireStore2(
          patientID: id,
          patientUrl: image,
          patientName: name,
          patientEmail: email,
          chooseStatus: 'Patient',
          patientAge: age,
          patientAdress: address,
          patientHeight: height,
          patientWeight: weight,
          phoneNumber: phoneNumber,
          patientOccupation: patientOccupation,
          maritalStatus: maritalStatus,
          isPatientSmoking: isPatientSmoking,
          isPatientAlcoholic: isPatientAlcoholic,
          isPatientActive: isPatientActive,
          patientComplain: patientComplain,
          patientOnset: patientOnset,
          patientCourse: patientCourse,
          patientDuration: patientDuration,
          patientMedication: patientMedication,
          patientPainLevel: patientPainLevel,
          patientChronicDiseases: patientChronicDiseases,
          patientPastInjuries: patientPastInjuries,
          patientPastSurgeries: patientPastSurgeries,
          patientAllergies: patientAllergies,
          patientImmunization: patientImmunization,
          patientFamilyAlzheimer: patientFamilyAlzheimer,
          patientFamilyCancer: patientFamilyCancer,
          patientFamilyDiabetes: patientFamilyDiabetes,
          patientFamilyHeartDisease: patientFamilyHeartDisease,
          patientFamilyHighBloodPressure: patientFamilyHighBloodPressure,
          patientFamilyKidneyDisease: patientFamilyKidneyDisease,
          patientFamilyLiverDisease: patientFamilyLiverDisease,
          patientFamilyObesity: patientFamilyObesity,
          patientFamilyStroke: patientFamilyStroke,
          sex: sex,
        );
  }

  void _update2(BuildContext context) {
    String id = idx!;
    String name = namex!;
    String image = imagex!;
    String email = emailx!;
    String address = _addressController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String patientOccupation = _occupationController.text.trim();
    String maritalStatus = _maritalStatusController.text.trim();
    int? age = aging?.toInt() ?? int.parse(_AgeController.text);
    String sex = _sexController.text.trim();
    int? height = patientheight;
    int? weight = patienWeight;
    bool? isPatientSmoking = patientSmoking;
    bool? isPatientAlcoholic = patientalcholic;
    bool? isPatientActive = patientActive;

    String patientComplain = _chiefComplainController.text.trim();
    String patientOnset = _onsetController.text.trim();
    String patientCourse = _courseOfDiseaseController.text.trim();
    String patientDuration = _durationOfSymptomsController.text.trim();
    String patientMedication = _MedicationsController.text.trim();
    int? patientPainLevel = painScaleLevel;

    String patientChronicDiseases = _chronicDiseasesController.text.trim();
    String patientPastInjuries = _pastInjuriesController.text.trim();
    String patientPastSurgeries = _pastSurgeriesController.text.trim();
    String patientAllergies = _allergiesController.text.trim();
    String patientImmunization = _immunizationController.text.trim();

    bool? patientFamilyAlzheimer = patientFamilyAlzheimerx;
    bool? patientFamilyCancer = patientFamilyCancerx;
    bool? patientFamilyDiabetes = patientFamilyDiabetesx;
    bool? patientFamilyHeartDisease = patientFamilyHeartDiseasex;
    bool? patientFamilyHighBloodPressure = patientFamilyHighBloodPressurex;
    bool? patientFamilyKidneyDisease = patientFamilyKidneyDiseasex;
    bool? patientFamilyLiverDisease = patientFamilyLiverDiseasex;
    bool? patientFamilyObesity = patientFamilyObesityx;
    bool? patientFamilyStroke = patientFamilyStrokex;

    // Call the updatePatientDataToFireStore method from your Cubit
    context.read<LayoutCubit>().sendPatientDataToFireStore2(
          patientID: id,
          patientUrl: image,
          patientName: name,
          patientEmail: email,
          chooseStatus: 'Patient',
          patientAge: age,
          patientAdress: address,
          patientHeight: height,
          patientWeight: weight,
          phoneNumber: phoneNumber,
          patientOccupation: patientOccupation,
          maritalStatus: maritalStatus,
          isPatientSmoking: isPatientSmoking,
          isPatientAlcoholic: isPatientAlcoholic,
          isPatientActive: isPatientActive,
          patientComplain: patientComplain,
          patientOnset: patientOnset,
          patientCourse: patientCourse,
          patientDuration: patientDuration,
          patientMedication: patientMedication,
          patientPainLevel: patientPainLevel,
          patientChronicDiseases: patientChronicDiseases,
          patientPastInjuries: patientPastInjuries,
          patientPastSurgeries: patientPastSurgeries,
          patientAllergies: patientAllergies,
          patientImmunization: patientImmunization,
          patientFamilyAlzheimer: patientFamilyAlzheimer,
          patientFamilyCancer: patientFamilyCancer,
          patientFamilyDiabetes: patientFamilyDiabetes,
          patientFamilyHeartDisease: patientFamilyHeartDisease,
          patientFamilyHighBloodPressure: patientFamilyHighBloodPressure,
          patientFamilyKidneyDisease: patientFamilyKidneyDisease,
          patientFamilyLiverDisease: patientFamilyLiverDisease,
          patientFamilyObesity: patientFamilyObesity,
          patientFamilyStroke: patientFamilyStroke,
          sex: sex,
        );
  }

  void _update3(BuildContext context) {
    String id = idx!;
    String name = namex!;
    String image = imagex!;
    String email = emailx!;
    String address = _addressController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String patientOccupation = _occupationController.text.trim();
    String maritalStatus = _maritalStatusController.text.trim();
    int? age = aging?.toInt() ?? int.parse(_AgeController.text);
    String sex = _sexController.text.trim();
    int? height = patientheight;
    int? weight = patienWeight;
    bool? isPatientSmoking = patientSmoking;
    bool? isPatientAlcoholic = patientalcholic;
    bool? isPatientActive = patientActive;

    String patientComplain = _chiefComplainController.text.trim();
    String patientOnset = _onsetController.text.trim();
    String patientCourse = _courseOfDiseaseController.text.trim();
    String patientDuration = _durationOfSymptomsController.text.trim();
    String patientMedication = _MedicationsController.text.trim();
    int? patientPainLevel = patienPain;

    String patientChronicDiseases = _chronicDiseasesController.text.trim();
    String patientPastInjuries = _pastInjuriesController.text.trim();
    String patientPastSurgeries = _pastSurgeriesController.text.trim();
    String patientAllergies = _allergiesController.text.trim();
    String patientImmunization = _immunizationController.text.trim();

    bool? patientFamilyAlzheimer = patientFamilyAlzheimerx;
    bool? patientFamilyCancer = patientFamilyCancerx;
    bool? patientFamilyDiabetes = patientFamilyDiabetesx;
    bool? patientFamilyHeartDisease = patientFamilyHeartDiseasex;
    bool? patientFamilyHighBloodPressure = patientFamilyHighBloodPressurex;
    bool? patientFamilyKidneyDisease = patientFamilyKidneyDiseasex;
    bool? patientFamilyLiverDisease = patientFamilyLiverDiseasex;
    bool? patientFamilyObesity = patientFamilyObesityx;
    bool? patientFamilyStroke = patientFamilyStrokex;

    // Call the updatePatientDataToFireStore method from your Cubit
    context.read<LayoutCubit>().sendPatientDataToFireStore2(
          patientID: id,
          patientUrl: image,
          patientName: name,
          patientEmail: email,
          chooseStatus: 'Patient',
          patientAge: age,
          patientAdress: address,
          patientHeight: height,
          patientWeight: weight,
          phoneNumber: phoneNumber,
          patientOccupation: patientOccupation,
          maritalStatus: maritalStatus,
          isPatientSmoking: isPatientSmoking,
          isPatientAlcoholic: isPatientAlcoholic,
          isPatientActive: isPatientActive,
          patientComplain: patientComplain,
          patientOnset: patientOnset,
          patientCourse: patientCourse,
          patientDuration: patientDuration,
          patientMedication: patientMedication,
          patientPainLevel: patientPainLevel,
          patientChronicDiseases: patientChronicDiseases,
          patientPastInjuries: patientPastInjuries,
          patientPastSurgeries: patientPastSurgeries,
          patientAllergies: patientAllergies,
          patientImmunization: patientImmunization,
          patientFamilyAlzheimer: patientFamilyAlzheimer,
          patientFamilyCancer: patientFamilyCancer,
          patientFamilyDiabetes: patientFamilyDiabetes,
          patientFamilyHeartDisease: patientFamilyHeartDisease,
          patientFamilyHighBloodPressure: patientFamilyHighBloodPressure,
          patientFamilyKidneyDisease: patientFamilyKidneyDisease,
          patientFamilyLiverDisease: patientFamilyLiverDisease,
          patientFamilyObesity: patientFamilyObesity,
          patientFamilyStroke: patientFamilyStroke,
          sex: sex,
        );
  }

  void _update4(BuildContext context) {
    String id = idx!;
    String name = namex!;
    String image = imagex!;
    String email = emailx!;
    String address = _addressController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String patientOccupation = _occupationController.text.trim();
    String maritalStatus = _maritalStatusController.text.trim();
    int? age = aging?.toInt() ?? int.parse(_AgeController.text);
    String sex = _sexController.text.trim();
    int? height = patientheight;
    int? weight = patienWeight;
    bool? isPatientSmoking = patientSmoking;
    bool? isPatientAlcoholic = patientalcholic;
    bool? isPatientActive = patientActive;

    String patientComplain = _chiefComplainController.text.trim();
    String patientOnset = _onsetController.text.trim();
    String patientCourse = _courseOfDiseaseController.text.trim();
    String patientDuration = _durationOfSymptomsController.text.trim();
    String patientMedication = _MedicationsController.text.trim();
    int? patientPainLevel = patienPain;

    String patientChronicDiseases = _chronicDiseasesController.text.trim();
    String patientPastInjuries = _pastInjuriesController.text.trim();
    String patientPastSurgeries = _pastSurgeriesController.text.trim();
    String patientAllergies = _allergiesController.text.trim();
    String patientImmunization = _immunizationController.text.trim();
//
    // Call the updatePatientDataToFireStore method from your Cubit
    context.read<LayoutCubit>().sendPatientDataToFireStore2(
          patientID: id,
          patientUrl: image,
          patientName: name,
          patientEmail: email,
          chooseStatus: 'Patient',
          patientAge: age,
          patientAdress: address,
          patientHeight: height,
          patientWeight: weight,
          phoneNumber: phoneNumber,
          patientOccupation: patientOccupation,
          maritalStatus: maritalStatus,
          isPatientSmoking: isPatientSmoking,
          isPatientAlcoholic: isPatientAlcoholic,
          isPatientActive: isPatientActive,
          patientComplain: patientComplain,
          patientOnset: patientOnset,
          patientCourse: patientCourse,
          patientDuration: patientDuration,
          patientMedication: patientMedication,
          patientPainLevel: patientPainLevel,
          patientChronicDiseases: patientChronicDiseases,
          patientPastInjuries: patientPastInjuries,
          patientPastSurgeries: patientPastSurgeries,
          patientAllergies: patientAllergies,
          patientImmunization: patientImmunization,
          patientFamilyAlzheimer: patientFamilyAlzheimer,
          patientFamilyCancer: patientFamilyCancer,
          patientFamilyDiabetes: patientFamilyDiabetes,
          patientFamilyHeartDisease: patientFamilyHeartDisease,
          patientFamilyHighBloodPressure: patientFamilyHighBloodPressure,
          patientFamilyKidneyDisease: patientFamilyKidneyDisease,
          patientFamilyLiverDisease: patientFamilyLiverDisease,
          patientFamilyObesity: patientFamilyObesity,
          patientFamilyStroke: patientFamilyStroke,
          sex: sex,
        );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        calculateAge(); // Call calculateAge after selecting a date
      });
    }
  }

  String calculateAge() {
    if (selectedDate != null) {
      DateTime now = DateTime.now();
      int? age = now.year - selectedDate!.year;

      // Adjust age if birthday hasn't occurred yet this year
      if (now.month < selectedDate!.month ||
          (now.month == selectedDate!.month && now.day < selectedDate!.day)) {
        age--;
      }
      aging = age;

      return '$age years'; // Return only the years
    } else {
      return ''; // Return empty string if no birth date is selected
    }
  }
}

class Tap_Widget extends StatelessWidget {
  final String TapName;
  const Tap_Widget({
    super.key,
    required this.TapName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20), // Adjust the value as needed
      ),
      width: 170,
      child: Tab(
        text: TapName,
      ),
    );
  }
}

class textField extends StatelessWidget {
  textField(
      {required this.fieldWidth,
      required this.fieldName,
      required this.controller});
  double fieldWidth;
  String fieldName;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 50,
      width: fieldWidth,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: TextStyle(
            color: AppColor.gradientFirst,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            // Border when the field is focused
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: AppColor.gradientFirst),
          ),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class boolenQuestion extends StatefulWidget {
  final ValueChanged<bool?> onChanged;
  final String question;

  const boolenQuestion(
      {Key? key, required this.onChanged, required this.question})
      : super(key: key);

  @override
  _boolenQuestionState createState() => _boolenQuestionState();
}

class _boolenQuestionState extends State<boolenQuestion> {
  bool? boolen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: TextStyle(fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Checkbox(
                  value: boolen == true,
                  onChanged: (value) {
                    setState(() {
                      boolen = value;
                      if (value != null) widget.onChanged(value);
                    });
                  },
                ),
                Text('Yes'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: boolen == false,
                  onChanged: (value) {
                    setState(() {
                      boolen = !value!;
                      if (value != null) widget.onChanged(!value);
                    });
                  },
                ),
                Text('No'),
              ],
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
      ],
    );
  }
}
