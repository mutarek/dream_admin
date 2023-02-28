import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? docId;
  String? connecting_date;
  String? email;
  bool? is_approved;
  String? mobileNumber;
  String? teamNo;
  String? permitCode;
  String? userName;
  String? userProfile;
  String? nidOrBirth;
  String? password;

  UserModel(
      {this.connecting_date,
      this.email,
      this.is_approved,
      this.mobileNumber,
      this.teamNo,
      this.permitCode,
      this.userName,
      this.userProfile,
      this.nidOrBirth,
      this.password});

  UserModel.fromMap({required DocumentSnapshot documentSnapshot}){
    docId = documentSnapshot.id;
    connecting_date = documentSnapshot['connecting_date'];
    email = documentSnapshot['email'];
    is_approved = documentSnapshot['is_approved'];
    mobileNumber = documentSnapshot['mobile_number'];
    teamNo = documentSnapshot['teamNo'];
    userName = documentSnapshot['user_name'];
    permitCode = documentSnapshot['permitCode'];
    userProfile = documentSnapshot['user_profileUrl'];
    nidOrBirth = documentSnapshot['nidOrBirthUrl'];
    password = documentSnapshot['password'];
  }
}
