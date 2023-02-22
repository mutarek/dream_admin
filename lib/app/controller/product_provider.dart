import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/image_compressed.dart';

class ProductsProvider extends ChangeNotifier{

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

  clearImage(int index){
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

  addProducts(String title, String description,String docsId,Function callback){
    final usersRef = FirebaseFirestore.instance.collection("Users").doc(docsId);
    Map<String, dynamic> data = {
      'title': title,
      'desc': description,
      'image': photoUrl,
      'created_at': DateTime.now(),
    };
    usersRef.collection("Products").add(data).then((value){
      callback(true);
      isLoading = false;
      notifyListeners();
    }).catchError((error){
      callback(false);
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: error);
    });;
  }

}