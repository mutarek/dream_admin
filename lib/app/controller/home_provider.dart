import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  bool isLoading  = false;

  Future<bool> createAdminAccount(String email, String password) async{
    isLoading = true;
    notifyListeners();
    try{
      _auth.createUserWithEmailAndPassword(email: email, password: password);
      isLoading = false;
      notifyListeners();
      return true;
    }
    catch(e){
      isLoading = false;
      notifyListeners();
      print(e);
      return false;
    }
  }
}
