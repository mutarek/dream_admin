import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/notice_model.dart';

class NoticeController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  var noticeModel = <NoticeModel>[].obs;
  var isLoading = true.obs;


  @override
  void onInit() async{
    collectionReference = firebaseFirestore.collection('Notice');
    noticeModel.clear();
    noticeModel.bindStream(getAllNotice());
    super.onInit();
  }

  Stream<List<NoticeModel>> getAllNotice() {
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
  deleteNotice(String id,int index) {
    collectionReference.doc(id).delete().then((value){
      noticeModel.removeAt(index);
      Fluttertoast.showToast(msg: "Notice deleted");
      Get.back();
    }).catchError((onError){
      Fluttertoast.showToast(msg: "Something went wrong ${onError.message}");
    });
  }
}