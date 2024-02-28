import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/user_model.dart';
import '../../../controller/cubit/layout_cubit.dart';

class ShowPatientProfileScreen extends StatelessWidget {
  ShowPatientProfileScreen({super.key, required this.user});
  final UserModel user;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(
                      16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(width: 2, color: Colors.black45)),
                    child: CircleAvatar(
                        radius: 50,
                        // Add your profile image here
                        backgroundImage: NetworkImage(user!.image!)),
                  ),
                  Center(
                    child: Text(
                      user.name ?? '',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff542D94)),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
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
                            child: ExpansionTile(
                              title: Text(
                                'Personal History',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              children: [
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.email_sharp,
                                  CardInfo: '${user.email}',
                                  cardName: 'Email',
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.numbers,
                                      CardInfo: user.patientAge != null
                                          ? '${user.patientAge} years'
                                          : 'Not available',
                                      cardName: 'Age',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.male,
                                      CardInfo: user.sex != null
                                          ? '${user.sex}'
                                          : 'Not available',
                                      cardName: 'Sex',
                                    ),
                                  ],
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.location_on_rounded,
                                  CardInfo:
                                      user.patientAdress ?? 'Not available',
                                  cardName: 'Address',
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.family_restroom,
                                      CardInfo: user.maritalStatus != null
                                          ? '${user.maritalStatus}'
                                          : 'Not available',
                                      cardName: 'Status',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.carpenter,
                                      CardInfo: user.patientOccupation != null
                                          ? '${user.patientWeight}'
                                          : 'Not available',
                                      cardName: 'Occupation',
                                    ),
                                  ],
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.phone,
                                  CardInfo: user.phoneNumber != null
                                      ? '${user.patientHeight}'
                                      : 'Not available',
                                  cardName: 'Phone',
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.height_sharp,
                                      CardInfo: user.patientHeight != null
                                          ? '${user.patientHeight} Cm'
                                          : 'Not available',
                                      cardName: 'Height',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.monitor_weight_sharp,
                                      CardInfo: user.patientWeight != null
                                          ? '${user.patientWeight} Kg'
                                          : 'Not available',
                                      cardName: 'Weight',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.smoking_rooms_sharp,
                                      CardInfo: user.isPatientSmoking != null
                                          ? '${user.isPatientSmoking}'
                                          : 'Not available',
                                      cardName: 'Smoke',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.local_drink,
                                      CardInfo: user.isPatientAlcoholic != null
                                          ? '${user.isPatientAlcoholic}'
                                          : 'Not available',
                                      cardName: 'Alcoholic',
                                    ),
                                  ],
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.sports_martial_arts_sharp,
                                  CardInfo: user.isPatientActive != null
                                      ? '${user.isPatientActive}'
                                      : 'Not available',
                                  cardName: 'Active',
                                ),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
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
                            child: ExpansionTile(
                              title: Text(
                                'Present History',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              children: [
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.short_text_sharp,
                                  CardInfo: user.patientComplain != null
                                      ? '${user.patientComplain}'
                                      : 'Not available',
                                  cardName: 'Chief Complain',
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.numbers,
                                      CardInfo: user.patientPainLevel != null
                                          ? '${user.patientPainLevel} / 10'
                                          : 'Not available',
                                      cardName: 'VPS',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.date_range,
                                      CardInfo: user.patientDuration != null
                                          ? '${user.patientDuration}'
                                          : 'Not available',
                                      cardName: 'Duration',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.short_text_sharp,
                                      CardInfo: user.patientOnset != null
                                          ? '${user.patientOnset}'
                                          : 'Not available',
                                      cardName: 'Onset',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.short_text_sharp,
                                      CardInfo: user.patientCourse != null
                                          ? '${user.patientCourse}'
                                          : 'Not available',
                                      cardName: 'Course',
                                    ),
                                  ],
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.medication_sharp,
                                  CardInfo: user.patientMedication != null
                                      ? '${user.patientMedication}'
                                      : 'Not available',
                                  cardName: 'Medication',
                                ),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
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
                            child: ExpansionTile(
                              title: Text(
                                'Past History',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              children: [
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.short_text_sharp,
                                  CardInfo: user.patientChronicDiseases != null
                                      ? '${user.patientChronicDiseases}'
                                      : 'Not available',
                                  cardName: 'Chronic Diseases',
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.short_text_sharp,
                                  CardInfo: user.patientPastInjuries != null
                                      ? '${user.patientPastInjuries}'
                                      : 'Not available',
                                  cardName: 'Past Injuries',
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.short_text_sharp,
                                  CardInfo: user.patientPastSurgeries != null
                                      ? '${user.patientPastSurgeries}'
                                      : 'Not available',
                                  cardName: 'Past Surgeries',
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.short_text_sharp,
                                  CardInfo: user.patientAllergies != null
                                      ? '${user.patientAllergies}'
                                      : 'Not available',
                                  cardName: 'Allergies',
                                ),
                                show_user_info_card(
                                  user: user,
                                  CardIcon: Icons.short_text_sharp,
                                  CardInfo: user.patientImmunization != null
                                      ? '${user.patientImmunization}'
                                      : 'Not available',
                                  cardName: 'Immunization',
                                ),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
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
                            child: ExpansionTile(
                              title: Text(
                                'Family History',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo: user
                                                  .patientFamilyHeartDisease !=
                                              null
                                          ? '${user.patientFamilyHeartDisease}'
                                          : 'Not available',
                                      cardName: 'Heart Dis..',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo: user.patientFamilyStroke != null
                                          ? '${user.patientFamilyStroke}'
                                          : 'Not available',
                                      cardName: 'Stroke',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo:
                                          user.patientFamilyHighBloodPressure !=
                                                  null
                                              ? '${user.patientFamilyHighBloodPressure}'
                                              : 'Not available',
                                      cardName: 'Pressure',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo:
                                          user.patientFamilyDiabetes != null
                                              ? '${user.patientFamilyDiabetes}'
                                              : 'Not available',
                                      cardName: 'Diabetes',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo: user
                                                  .patientFamilyLiverDisease !=
                                              null
                                          ? '${user.patientFamilyLiverDisease}'
                                          : 'Not available',
                                      cardName: 'Liver Dis..',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo:
                                          user.patientFamilyObesity != null
                                              ? '${user.patientFamilyObesity}'
                                              : 'Not available',
                                      cardName: 'Obesity',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo: user
                                                  .patientFamilyKidneyDisease !=
                                              null
                                          ? '${user.patientFamilyKidneyDisease}'
                                          : 'Not available',
                                      cardName: 'Kidney Dis..',
                                    ),
                                    show_user_info_semi_card(
                                      user: user,
                                      CardIcon: Icons.question_mark_sharp,
                                      CardInfo: user.patientFamilyCancer != null
                                          ? '${user.patientFamilyCancer}'
                                          : 'Not available',
                                      cardName: 'Cancer',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class show_user_info_card extends StatelessWidget {
  const show_user_info_card(
      {super.key,
      required this.CardIcon,
      required this.CardInfo,
      required this.user,
      required this.cardName});
  final String cardName;
  final String CardInfo;
  final IconData CardIcon;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Stack(
        children: [
          Card(
            margin: const EdgeInsets.only(top: 12),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black45),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    CardInfo,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87.withOpacity(0.8)),
                  ),
                  Icon(CardIcon,
                      color: const Color(0xff542D94).withOpacity(0.8))
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                cardName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff542D94).withOpacity(0.9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class show_user_info_semi_card extends StatelessWidget {
  const show_user_info_semi_card(
      {super.key,
      required this.CardIcon,
      required this.CardInfo,
      required this.user,
      required this.cardName});
  final String cardName;
  final String CardInfo;
  final IconData CardIcon;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 32,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Card(
            margin: const EdgeInsets.only(top: 20),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black45),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 92,
                    child: Text(
                      CardInfo,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87.withOpacity(0.8)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Icon(
                    CardIcon,
                    color: Color(0xff542D94).withOpacity(0.8),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                cardName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff542D94).withOpacity(0.9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
