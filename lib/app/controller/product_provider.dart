import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/image_compressed.dart';

class ProductsProvider extends ChangeNotifier{

  bool isLoading = false;

  List<XFile> imageFile = [];
  List<File> afterConvertImageLists = [];
  File? singleImage;
  List<File> video = [];
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

}