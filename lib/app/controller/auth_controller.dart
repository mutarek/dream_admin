import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  bool login(String email, String password) {
    isLoading(true);
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading(false);
      return true;
    } catch (error) {
      isLoading(false);
      return false;
    }
  }
}
