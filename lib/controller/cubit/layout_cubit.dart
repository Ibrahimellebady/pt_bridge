import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elag/Models/exrecies_model.dart';
import 'package:elag/Models/message_model.dart';
import 'package:elag/Models/user_model.dart';
import 'package:elag/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../Models/request_model.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  UserModel? userModel;

  void getUsersData() async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(Constants.userID)
          .get()
          .then((value) {
        if (value.data() != null) {
          userModel = UserModel.fromJson(data: value.data()!);
        }
      });
      emit(SuccessGetUsersDataState());
    } on FirebaseException {
      emit(FailedToGetMyDataState());
    }
  }

  ExerciseModel? exerciseModel;
  List<RequestModel?>? patientRequestList;

  String? requestStatus;

  Future<void> getRequestValidation({required String doctorID}) async {
    emit(GetRequestDataLoadingState());
    RequestModel? requestModel = RequestModel();

    await FirebaseFirestore.instance
        .collection('Requests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      requestStatus = "";
      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.id.contains(userModel!.id! + doctorID)) {
          // Document ID contains the substring, you can access its data here
          print(documentSnapshot.data());
          requestModel = RequestModel.fromJson(
              data: documentSnapshot.data() as Map<String, dynamic>);
          requestStatus = requestModel!.status;
        } else if (documentSnapshot.id.contains(userModel!.id!)) {
          // Document ID contains the substring, you can access its data here
          requestStatus = "have doctor";
        }
      });
      print("legnth===");
      print(patientRequestList?.length);
      emit(GetRequestDataSuccessState());
    }).catchError((error) {
      // Handle any errors that occur
      print('Error getting requests: $error');
      emit(GetRequestDataFailureState());
    });
  }

  Future<void> getPatientRequestValidation({required String doctorID}) async {
    emit(GetRequestDataLoadingState());
    patientRequestList = [];
    RequestModel? requestModel = RequestModel();
    await FirebaseFirestore.instance
        .collection('Requests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.id.contains(doctorID)) {
          // Document ID contains the substring, you can access its data here
          print(documentSnapshot.data());
          requestModel = RequestModel.fromJson(
              data: documentSnapshot.data() as Map<String, dynamic>);
          requestStatus = requestModel!.status;
          patientRequestList!.add(requestModel!);
          print(patientRequestList![0]?.patientID);
        }
      });
      print("legnth===");
      print(patientRequestList?.length);
      emit(GetRequestDataSuccessState());
    }).catchError((error) {
      // Handle any errors that occur
      print('Error getting requests: $error');
      emit(GetRequestDataFailureState());
    });
  }

  void getExreciesData() async {
    try {
      await FirebaseFirestore.instance
          .collection('Exercise')
          .doc(Constants.userID)
          .get()
          .then((value) {
        if (value.data() != null) {
          exerciseModel = ExerciseModel.fromJson(data: value.data()!);
        }
      });
      emit(SuccessGetUsersDataState());
    } on FirebaseException {
      emit(FailedToGetMyDataState());
    }
  }

  List<UserModel> users = [];

  void getUsers() async {
    users.clear();
    emit(GetUsersLoadingState());
    try {
      await FirebaseFirestore.instance.collection('Users').get().then((value) {
        for (var item in value.docs) {
          if (item.id != Constants.userID) {
            users.add(UserModel.fromJson(data: item.data()));
          }
        }
        emit(GetUsersDataSuccessState());
      });
    }
    // on FirebaseException
    catch (e) {
      users = [];
      emit(FailedToGetUsersDataState());
    }
  }

  List<ExerciseModel> exrecises = [];
  List<String> exercisesID = [];
  void getExreciesList() async {
    exrecises.clear();
    exercisesID.clear();
    emit(GetExreciesLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('Exercise')
          .get()
          .then((value) {
        for (var item in value.docs) {
          if (item.id != Constants.exerciseID) {
            exercisesID.add(item.id);
            exrecises.add(ExerciseModel.fromJson(data: item.data()));
          }
        }
        emit(GetUsersDataSuccessState());
      });
    }
    //on FirebaseException
    catch (e) {
      exrecises = [];
      emit(FailedToGetUsersDataState());
    }
  }

  List<UserModel> patient = [];
  List<UserModel> patientPending = [];
  void getPatient() async {
    patient = [];
    patientPending = [];
    emit(FilterPatientForUserLoadingState());
    await getPatientRequestValidation(doctorID: userModel!.id!).then((value) {
      FirebaseFirestore.instance
          .collection('Users')
          .where('chooseStatus', whereIn: ['Patient'])
          .get()
          .then((value) async {
            UserModel patientModel = UserModel();
            for (var element in value.docs) {
              final data = element.data();
              patientModel = UserModel.fromJson(data: data);
              print("patientRequestList= ${patientRequestList!.length}");
              for (var e in patientRequestList!) {
                print("${e!.patientID}    and  ${patientModel.id}");
                if (e?.patientID == patientModel.id) {
                  if (e!.status == "accept") {
                    patient.add(UserModel.fromJson(data: element.data()));
                  } else if (e.status == "pending") {
                    patientPending
                        .add(UserModel.fromJson(data: element.data()));
                  }
                }
              }
            }
            print(patientPending.length);
            emit(FilterPatientForUserSuccessState());
          });
    });
    // arrayContain will get all userName that contain input which user will type on textFormField
  }

  void doctorAcceptPatient(int index) {
    emit(DoctorAcceptPatientLoadingState());
    RequestModel requestModel = RequestModel(
        doctorID: userModel!.id!,
        patientID: patientPending[index].id!,
        status: "accept");
    FirebaseFirestore.instance
        .collection('Requests')
        .doc(patientPending[index].id! + userModel!.id!)
        .update(requestModel.toJson())
        .then((value) {
      patient.add(patientPending[index]);
      patientPending.removeAt(index);
      emit(DoctorAcceptPatientSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(DoctorAcceptPatientFailureState());
    });
  }

  void doctorRejectPatient(int index) {
    emit(DoctorAcceptPatientLoadingState());
    // RequestModel requestModel=RequestModel(doctorID: userModel!.id!,
    //     patientID: patientPending[index].id!,
    //     status: "reject"
    // );
    FirebaseFirestore.instance
        .collection('Requests')
        .doc(patientPending[index].id! + userModel!.id!)
        .delete()
        // update(requestModel.toJson()).
        .then((value) {
      patientPending.removeAt(index);
      emit(DoctorAcceptPatientSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(DoctorAcceptPatientFailureState());
    });
  }

  List<UserModel> therapist = [];

  void getTherapist() {
    therapist = [];
    emit(FilterTherapistForUserLoadingState());
    // arrayContain will get all userName that contain input which user will type on textFormField
    FirebaseFirestore.instance
        .collection('Users')
        .where('chooseStatus', whereIn: ['Therapist'])
        .get()
        .then((value) {
          for (var element in value.docs) {
            therapist.add(UserModel.fromJson(data: element.data()));
            emit(FilterTherapistForUserSuccessState());
          }
        });
  }

  List<UserModel> usersFiltered = [];

  void searchAboutUser({required String query}) {
    usersFiltered = users
        .where((element) =>
            element.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(FilteredUsersSuccessState());
  }

  List<UserModel> patientsFiltered = [];

  void searchAboutPatient({required String query}) {
    patientsFiltered = patient
        .where((element) =>
            element.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(FilteredPatientsSuccessState());
  }

  List<UserModel> therapistsFiltered = [];

  void searchAboutTherapists({required String query}) {
    therapistsFiltered = therapist
        .where((element) =>
            element.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(FilteredPatientsSuccessState());
  }

  bool searchEnabled = false;

  void changeSearchStatus() {
    searchEnabled = !searchEnabled;
    if (searchEnabled == false) usersFiltered.clear();
    emit(ChangeSearchUserSuccessState());
  }

  bool searchTherapistEnabled = false;

  void changeSearchTherapistStatus() {
    searchTherapistEnabled = !searchTherapistEnabled;
    if (searchTherapistEnabled == false) therapistsFiltered.clear();
    emit(ChangeSearchTherapistSuccessState());
  }

  bool searchPatientEnabled = false;

  void changeSearchPatientStatus() {
    searchPatientEnabled = !searchPatientEnabled;
    if (searchPatientEnabled == false) patientsFiltered.clear();
    emit(ChangeSearchPatientSuccessState());
  }

  void sendMessage(
      {required String message, required String receiverID}) async {
    MessageModel messageModel = MessageModel(
        title: message,
        date: DateTime.now().toString(),
        senderID: Constants.userID);
    // Save Data on my Document
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(Constants.userID)
        .collection("Chat")
        .doc(receiverID)
        .collection("Messages")
        .add(messageModel.toJson());
    debugPrint("Message Sent success ......");
    // Save Data on Receiver Document
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(receiverID)
        .collection("Chat")
        .doc(Constants.userID)
        .collection("Messages")
        .add(messageModel.toJson());
    emit(SendMessageSuccessState());
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverID}) {
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Constants.userID)
        .collection('Chat')
        .doc(receiverID)
        .collection('Messages')
        .orderBy('date')
        .snapshots()
        .listen((value) {
      messages.clear();
      for (var item in value.docs) {
        messages.add(MessageModel.fromJson(data: item.data()));
      }
      debugPrint("Messages length is : ${messages.length}");
      emit(GetMessagesSuccessState());
    });
  }

  Future<void> deleteExerciseCollection(String receiverID) async {
    // Reference to the "Exercise" collection
    CollectionReference exerciseSenderCollection = FirebaseFirestore.instance
        .collection("Users")
        .doc(Constants.userID)
        .collection("Chat")
        .doc(receiverID)
        .collection("Exercise");
    print("data");
    var snapshot = await exerciseSenderCollection.get();
    print("gert data");
    print(snapshot.docs.length);
    for (var doc in snapshot.docs) {
      print(doc.data());
      await doc.reference.delete().then((value) {
        debugPrint("Exercise collection deleted successfully");
      }).catchError((onError) {
        debugPrint(onError);
      });
    }

    CollectionReference exerciseReceiverCollection = FirebaseFirestore.instance
        .collection("Users")
        .doc(receiverID)
        .collection("Chat")
        .doc(Constants.userID)
        .collection("Exercise");
    print("data");
    var snapshotReceiver = await exerciseReceiverCollection.get();
    print("gert data");
    print(snapshotReceiver.docs.length);
    for (var doc in snapshotReceiver.docs) {
      await doc.reference.delete().then((value) {
        debugPrint("Exercise collection deleted successfully for receiver");
      }).catchError((onError) {
        debugPrint(onError);
      });
    }
    // Retrieve all documents in the "Exercise" collection
    // QuerySnapshot querySnapshot = await exerciseCollection.get();
    // // Create a batch operation
    // WriteBatch batch = FirebaseFirestore.instance.batch();
    //
    // // Add delete operations for each document in the collection to the batch
    // querySnapshot.docs.forEach((DocumentSnapshot document) {
    //   batch.delete(document.reference);
    // });
    //
    // // Commit the batched operation to delete all documents in the collection
    // await batch.commit();
    // exerciseCollection.doc("0Pam1Ozvkfi51jcUFAhN").delete().then((value) {
    //   print("success");
    //
    // }).catchError((onError){
    //   print(onError);
    // });
    // Delete the "Exercise" collection
    // await exerciseCollection.parent!.delete().then((value){});
    // Print a debug message after successful deletion

    print("collection deleted successfully");
  }

  List<bool> isSelected = List.generate(9999999, (index) => false);
  void checkboxIsSelected(bool value, int index) {
    isSelected[index] = value;
    emit(ChangeSearchPatientSuccessState());
  }

  void checkboxSelectedPrevious() {}
  void sendExercise({
    required String title,
    required String receiverID,
    required String body,
    required String image,
    required int index,
    required String steps,
  }) async {
    ExerciseModel exerciseModel = ExerciseModel(
        title: title,
        body: body,
        image: image,
        steps: steps,
        date: DateTime.now().toString(),
        senderID: Constants.userID);
    // Save Data on my Document
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(Constants.userID)
        .collection("Chat")
        .doc(receiverID)
        .collection("Exercise")
        .doc(exercisesID[index])
        .set(exerciseModel.toJson());
    // .add(exerciseModel.toJson());
    debugPrint("Exercise Sent success ......");
    // Save Data on Receiver Document
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(receiverID)
        .collection("Chat")
        .doc(Constants.userID)
        .collection("Exercise")
        .add(exerciseModel.toJson());
    emit(SendMessageSuccessState());
  }

////
  List<ExerciseModel> exerciseMessage = [];

  List<ExerciseModel> exercisesFiltered = [];

  void searchAboutExercise({required String query}) {
    exercisesFiltered = exrecises
        .where((element) =>
            element.title!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(FilteredExercisesSuccessState());
  }

  bool searchExerciseEnabled = false;

  void changeSearchExerciseStatus() {
    searchExerciseEnabled = !searchExerciseEnabled;
    if (searchExerciseEnabled == false) exercisesFiltered.clear();
    emit(ChangeSearchExerciseSuccessState());
  }

  ////

  void getExercise({required String receiverID}) {
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Constants.userID)
        .collection('Chat')
        .doc(receiverID)
        .collection('Exercise')
        .orderBy('date')
        .snapshots()
        .listen((value) {
      exerciseMessage.clear();
      for (var item in value.docs) {
        exerciseMessage.add(ExerciseModel.fromJson(data: item.data()));
        for (int i = 0; i < exercisesID.length; i++) {
          if (exercisesID[i] == item.id) {
            isSelected[i] = true;
          }
        }
      }
      debugPrint("ExerciseModel length is : ${exerciseMessage.length}");
      emit(GetMessagesSuccessState());
    });
  }

  void sendRequestToDoctor({required String doctorID}) {
    emit(GetMessagesLoadingState());
    RequestModel requestModel = RequestModel(
        status: "pending", patientID: Constants.userID, doctorID: doctorID);
    FirebaseFirestore.instance
        .collection('Requests')
        .doc(Constants.userID! + doctorID)
        .set(requestModel.toJson())
        .then((value) {
      print("added");
    });

    emit(GetMessagesSuccessState());
  }

  /////////////////
///////////////////

  List<ExerciseModel> _exercisesFiltered = [];

  List<ExerciseModel> get exercisesFilteredx => _exercisesFiltered;

  void filterExercises(String query) {
    if (query.isEmpty) {
      _exercisesFiltered = exrecises;
    } else {
      _exercisesFiltered = exrecises
          .where((exercise) =>
              exercise.title!.toLowerCase().contains(query.toLowerCase()) ||
              exercise.body!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    // Update the content of exercisesFiltered instead of redefining it
    _exercisesFiltered = _exercisesFiltered;
    emit(ExercisesFilteredState(_exercisesFiltered));
  }

  //////////////
//////////////

  List<ExerciseModel> Gaitexrecises = [];
  List<String> GaitexercisesID = [];
  void getGaitExreciesList() async {
    Gaitexrecises.clear();
    GaitexercisesID.clear();
    emit(GetExreciesLoadingState());
    FirebaseFirestore.instance
        .collection('Exercise')
        .where('body', whereIn: ['Gait training'])
        .get()
        .then(
          (value) {
            for (var element in value.docs) {
              Gaitexrecises.add(ExerciseModel.fromJson(data: element.data()));
              emit(FilterTherapistForUserSuccessState());
            }
          },
        );
  }

  List<RequestModel> RequestFiltered = [];
  List<String> RequestId = [];
  void getRequest() async {
    RequestFiltered.clear();
    RequestId.clear();
    emit(GetExreciesLoadingState());
    FirebaseFirestore.instance
        .collection('Requests')
        .where('patient_id', whereIn: [userModel!.id])
        .get()
        .then(
          (value) {
            for (var element in value.docs) {
              RequestFiltered.add(RequestModel.fromJson(data: element.data()));
              emit(FilterTherapistForUserSuccessState());
            }
          },
        );
  }

  RequestModel? requestModel;

  void getRequestData() async {
    try {
      String? patientId = userModel!.id;

      await FirebaseFirestore.instance
          .collection('Requests')
          .where('patient_id', isEqualTo: patientId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

          // Ensure that the data retrieved from Firestore is cast to Map<String, dynamic>
          Map<String, dynamic> requestData =
              documentSnapshot.data() as Map<String, dynamic>;

          // Convert the data to a RequestModel object
          requestModel = RequestModel.fromJson(data: requestData);
        }
      });
    } catch (e) {
      print('Error fetching request data: $e');
      // Handle error
    }
  }

  //////

  Future<void> sendPatientDataToFireStore2({
    required String patientUrl,
    required String patientName,
    required String patientEmail,
    required String patientID,
    required String chooseStatus,
    int? patientAge,
    String? patientAdress,
    String? phoneNumber,
    String? patientOccupation,
    String? maritalStatus,
    int? patientHeight,
    int? patientWeight,
    bool? isPatientSmoking,
    bool? isPatientAlcoholic,
    bool? isPatientActive,
    String? patientComplain,
    String? patientOnset,
    String? patientCourse,
    String? patientDuration,
    String? patientMedication,
    int? patientPainLevel,
    String? patientChronicDiseases,
    String? patientPastInjuries,
    String? patientPastSurgeries,
    String? patientAllergies,
    String? patientImmunization,
    bool? patientFamilyHeartDisease,
    bool? patientFamilyStroke,
    bool? patientFamilyCancer,
    bool? patientFamilyDiabetes,
    bool? patientFamilyHighBloodPressure,
    bool? patientFamilyObesity,
    bool? patientFamilyAlzheimer,
    bool? patientFamilyKidneyDisease,
    bool? patientFamilyLiverDisease,
    String? sex,
  }) async {
    UserModel userModel = UserModel(
      name: patientName,
      email: patientEmail,
      image: patientUrl,
      id: patientID,
      chooseStatus: chooseStatus,
      patientAge: patientAge,
      patientHeight: patientHeight,
      patientWeight: patientWeight,
      patientAdress: patientAdress,
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
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(patientID)
          .set(userModel.toJson());

      emit(updatePatientDataOnFirestoreSuccessState());
    } on FirebaseException {
      emit(FailedToupdatePatientDataOnFirestoreState());
    }
  }
}
