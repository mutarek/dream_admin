import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class UserListController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  var userModel = <UserModel>[].obs;
  var unApprovedProfile = <UserModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    collectionReference = firebaseFirestore.collection('Users');
    userModel.bindStream(getUsers());
    unApprovedProfile.bindStream(getUnApprovedUser());
    super.onInit();
  }

  Stream<List<UserModel>> getUsers() {
    return collectionReference.where('is_approved',isEqualTo: true).snapshots().map((QuerySnapshot query) {
      List<UserModel> hotels = [];
      for (var hotel in query.docs) {
        final hotemote = UserModel.fromMap(documentSnapshot: hotel);
        hotels.add(hotemote);
        isLoading(false);
      }
      return hotels;
    });
  }

  Stream<List<UserModel>> getUnApprovedUser() {
    return collectionReference.where('is_approved',isEqualTo: false).snapshots().map((QuerySnapshot query) {
      List<UserModel> hotels = [];
      for (var hotel in query.docs) {
        final hotemote = UserModel.fromMap(documentSnapshot: hotel);
        hotels.add(hotemote);
        isLoading(false);
      }
      return hotels;
    });
  }
}
