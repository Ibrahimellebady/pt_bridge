class UserModel {
  String? name;
  String? image;
  String? email;
  String? id;
  String? chooseStatus;
  String? patientAdress;
  String? phoneNumber;
  String? patientOccupation;
  String? maritalStatus;
  String? patientStatus;
  int? patientAge;
  int? patientHeight;
  int? patientWeight;
  bool? isPatientSmoking;
  bool? isPatientAlcoholic;
  bool? isPatientActive;

  String? patientComplain;
  String? patientOnset;
  String? patientCourse;
  String? patientDuration;
  String? patientMedication;
  int? patientPainLevel;

  String? patientChronicDiseases;
  String? patientPastInjuries;
  String? patientPastSurgeries;
  String? patientAllergies;
  String? patientImmunization;

  bool? patientFamilyHeartDisease;
  bool? patientFamilyStroke;
  bool? patientFamilyCancer;
  bool? patientFamilyDiabetes;
  bool? patientFamilyHighBloodPressure;
  bool? patientFamilyObesity;
  bool? patientFamilyAlzheimer;
  bool? patientFamilyKidneyDisease;
  bool? patientFamilyLiverDisease;
  String? sex;
  String? doctorDiscription;
  UserModel(
      {this.name,
      this.email,
      this.id,
      this.image,
      this.chooseStatus,
      this.patientAdress,
      this.patientAge,
      this.patientHeight,
      this.patientStatus,
      this.patientWeight,
      this.phoneNumber,
      this.patientOccupation,
      this.maritalStatus,
      this.isPatientSmoking,
      this.isPatientAlcoholic,
      this.isPatientActive,
      this.patientComplain,
      this.patientOnset,
      this.patientCourse,
      this.patientDuration,
      this.patientMedication,
      this.patientPainLevel,
      this.patientAllergies,
      this.patientChronicDiseases,
      this.patientImmunization,
      this.patientPastInjuries,
      this.patientPastSurgeries,
      this.patientFamilyAlzheimer,
      this.patientFamilyCancer,
      this.patientFamilyDiabetes,
      this.patientFamilyHeartDisease,
      this.patientFamilyHighBloodPressure,
      this.patientFamilyKidneyDisease,
      this.patientFamilyLiverDisease,
      this.patientFamilyObesity,
      this.patientFamilyStroke,
      this.sex,
      this.doctorDiscription});
  // NamedConstructor => I will used it when i get Data from fireStore and save it on this model
  // refactoring map | json
  UserModel.fromJson({required Map<String, dynamic> data}) {
    name = data['name'];
    email = data['email'];
    image = data['image'];
    id = data['id'];
    chooseStatus = data['chooseStatus'];

    patientAdress = data['patientAdress'];
    patientStatus = data['patientStatus'];
    patientAge = data['patientAge'];
    patientHeight = data['patientHeight'];
    patientWeight = data['patientWeight'];
    phoneNumber = data['phoneNumber'];
    patientOccupation = data['patientOccupation'];
    maritalStatus = data['maritalStatus'];
    isPatientSmoking = data['isPatientSmoking'];

    isPatientAlcoholic = data['isPatientAlcoholic'];
    isPatientActive = data['isPatientActive'];

    patientComplain = data['patientComplain'];
    patientOnset = data['patientOnset'];
    patientCourse = data['patientCourse'];
    patientDuration = data['patientDuration'];
    patientMedication = data['patientMedication'];
    patientPainLevel = data['patientPainLevel'];

    patientChronicDiseases = data['patientChronicDiseases'];
    patientPastInjuries = data['patientPastInjuries'];
    patientPastSurgeries = data['patientPastSurgeries'];
    patientAllergies = data['patientAllergies'];
    patientImmunization = data['patientImmunization'];

    patientFamilyAlzheimer = data['patientFamilyAlzheimer'];
    patientFamilyCancer = data['patientFamilyCancer'];
    patientFamilyDiabetes = data['patientFamilyDiabetes'];
    patientFamilyHeartDisease = data['patientFamilyHeartDisease'];
    patientFamilyHighBloodPressure = data['patientFamilyHighBloodPressure'];
    patientFamilyKidneyDisease = data['patientFamilyKidneyDisease'];
    patientFamilyLiverDisease = data['patientFamilyLiverDisease'];
    patientFamilyObesity = data['patientFamilyObesity'];
    patientFamilyStroke = data['patientFamilyStroke'];

    sex = data['sex'];
    doctorDiscription = data['doctorDiscription'];
  }
  // TOJson  => I will used it when i want to  send data to cloud firestore ( Fields )
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'id': id,
      'chooseStatus': chooseStatus,
      'patientAdress': patientAdress,
      'patientStatus': patientStatus,
      'patientAge': patientAge,
      'patientHeight': patientHeight,
      'patientWeight': patientWeight,
      'phoneNumber': phoneNumber,
      'patientOccupation': patientOccupation,
      'maritalStatus': maritalStatus,
      'isPatientSmoking': isPatientSmoking,
      'isPatientAlcoholic': isPatientAlcoholic,
      'isPatientActive': isPatientActive,
      'patientComplain': patientComplain,
      'patientOnset': patientOnset,
      'patientCourse': patientCourse,
      'patientDuration': patientDuration,
      'patientMedication': patientMedication,
      'patientPainLevel': patientPainLevel,
      'patientChronicDiseases': patientChronicDiseases,
      'patientPastInjuries': patientPastInjuries,
      'patientPastSurgeries': patientPastSurgeries,
      'patientAllergies': patientAllergies,
      'patientImmunization': patientImmunization,
      'patientFamilyAlzheimer': patientFamilyAlzheimer,
      'patientFamilyCancer': patientFamilyCancer,
      'patientFamilyDiabetes': patientFamilyDiabetes,
      'patientFamilyHeartDisease': patientFamilyHeartDisease,
      'patientFamilyHighBloodPressure': patientFamilyHighBloodPressure,
      'patientFamilyKidneyDisease': patientFamilyKidneyDisease,
      'patientFamilyLiverDisease': patientFamilyLiverDisease,
      'patientFamilyObesity': patientFamilyObesity,
      'patientFamilyStroke': patientFamilyStroke,
      'sex': sex,
      'doctorDiscription': doctorDiscription,
    };
  }
}
