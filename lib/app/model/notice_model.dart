import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel{
  String? docId;
  String? title;
  String? description;

  NoticeModel({this.title, this.description,this.docId});

  NoticeModel.fromMap({required DocumentSnapshot documentSnapshot}){
    docId = documentSnapshot.id;
    title = documentSnapshot['title'];
    description = documentSnapshot['desc'];
  }
}