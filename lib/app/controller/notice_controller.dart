import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/notice_model.dart';

class NoticeController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  var noticeModel = <NoticeModel>[].obs;
  var isLoading = true.obs;
  var currentDocs = "".obs;


  @override
  void onInit() async{
    collectionReference = firebaseFirestore.collection('Notice');
    noticeModel.bindStream(getAllProducts());
    super.onInit();
  }

  Stream<List<NoticeModel>> getAllProducts() {
    isLoading(true);
    return collectionReference.snapshots().map((QuerySnapshot query) {
      List<NoticeModel> hotels = [];
      for (var hotel in query.docs) {
        final hotemote = NoticeModel.fromMap(documentSnapshot: hotel);
        hotels.add(hotemote);
        isLoading(false);
      }
      return hotels;
    });
  }
}