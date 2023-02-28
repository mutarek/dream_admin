import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String? docID;
  String? title;
  String? description;
  String? image;

  ProductModel({this.docID, this.title, this.description, this.image});

  ProductModel.fromMap({required DocumentSnapshot documentSnapshot}){
    docID = documentSnapshot.id;
    title = documentSnapshot['title'];
    description = documentSnapshot['desc'];
    image = documentSnapshot['image'];
  }
}
