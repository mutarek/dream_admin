import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<bool> login(String email, String password)async{
    isLoading = true;
    notifyListeners();
    try{
      _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading = false;
      notifyListeners();
      return true;
    }catch (e){
      isLoading = false;
      notifyListeners();
      print(e);
      return false;
    }
  }
  Future<bool> createAccount(String email, String password)async{
    isLoading = true;
    notifyListeners();
    try{
      _auth.createUserWithEmailAndPassword(email: email, password: password);
      isLoading = false;
      notifyListeners();
      return true;
    }catch (e){
      isLoading = false;
      notifyListeners();
      print(e);
      return false;
    }
  }

  void saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_logged", true);
  }
}