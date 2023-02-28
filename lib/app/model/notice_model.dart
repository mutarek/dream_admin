import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel{
  String? title;
  String? description;

  NoticeModel({this.title, this.description});

  NoticeModel.fromMap({required DocumentSnapshot documentSnapshot}){
    title = documentSnapshot['title'];
    description = documentSnapshot['desc'];
  }
}