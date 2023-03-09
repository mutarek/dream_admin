import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/image_compressed.dart';

class ProductsProvider extends ChangeNotifier {
  bool isLoading = false;
  String photoUrl = "";

  List<XFile> imageFile = [];
  List<File> afterConvertImageLists = [];
  File? singleImage;
  final _picker = ImagePicker();

  void pickImage() async {
    imageFile = [];
    var pickedFile = await _picker.pickMultiImage();
    if (pickedFile.isNotEmpty) {
      imageFile.addAll(pickedFile);
      for (var element in imageFile) {
        singleImage = File(element.path);
        afterConvertImageLists.add(await imageCompressed(imagePathToCompress: singleImage!));
        await imageCompressed(imagePathToCompress: singleImage!);
        notifyListeners();
      }
    }
  }

  clearImage(int index) {
    afterConvertImageLists.removeAt(index);
    notifyListeners();
  }

  clearCoverProfile() {
    singleImage = null;
    notifyListeners();
  }

  uploadPhoto(Function callback) async {
    isLoading = true;
    notifyListeners();
    String uniqueName = DateTime.now().toString();
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceroot.child("images");
    Reference referenceImagetoUpload = referenceDirImage.child(uniqueName);
    try {
      await referenceImagetoUpload.putFile(File(singleImage!.path));
      photoUrl = await referenceImagetoUpload.getDownloadURL();
      callback(true);
      notifyListeners();
    } catch (error) {
      callback(false);
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  updateFailedReport(String item, String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    Map<String, dynamic> data = {'failed': item};
    usersRef.update(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      callback(false);
      isLoading = false;
      notifyListeners();
      print(onError);
    });
  }

  updateLeadGena(String item, String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    Map<String, dynamic> data = {'lead': item};
    usersRef.update(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      callback(false);
      isLoading = false;
      notifyListeners();
      print(onError);
    });
  }

  updateSuccessReport(String item, String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    Map<String, dynamic> data = {'success': item};
    usersRef.update(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      callback(false);
      isLoading = false;
      notifyListeners();
      print(onError);
    });
  }

  updateWallet(String item, String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    Map<String, dynamic> data = {'wallet': item};
    usersRef.update(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      callback(false);
      isLoading = false;
      notifyListeners();
      print(onError);
    });
  }

  changeAccountStatus(String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    Map<String, dynamic> data = {'is_approved': false};
    usersRef.update(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      callback(false);
      isLoading = false;
      notifyListeners();
      print(onError);
    });
  }

  reopenAccount(String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    Map<String, dynamic> data = {'is_approved': true};
    usersRef.update(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      callback(false);
      isLoading = false;
      notifyListeners();
      print(onError);
    });
  }

  deleteUser(String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    usersRef.delete().then((value){
      callback(true);
      isLoading = false;
      Fluttertoast.showToast(msg: "User deleted");
      notifyListeners();
    }).catchError((onError){
      callback(false);
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: onError);
    });
  }

  addProducts(String title, String description, String path, Function callback) {
    final usersRef = FirebaseFirestore.instance.collection("Products");
    Map<String, dynamic> data = {'title': title, 'desc': description, 'image': photoUrl, 'created_at': DateTime.now()};
    usersRef.add(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      callback(false);
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: error);
    });
  }

  addNotice(String title, String description, String path, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Notice");
    Map<String, dynamic> data = {'title': title, 'desc': description, 'created_at': DateTime.now()};
    usersRef.add(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      callback(false);
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: error);
    });
  }

  createPaymentMethod(String ammount, String number, String method, String docsID, Function callback) {
    isLoading = true;
    notifyListeners();
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsID);
    Map<String, dynamic> data = {'amount': ammount, 'number': number, 'method': method, 'created_at': DateTime.now()};
    usersRef.collection('Payment').add(data).then((value) {
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      callback(false);
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: error);
    });
  }
}
