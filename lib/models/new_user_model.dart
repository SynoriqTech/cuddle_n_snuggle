import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NewUser {
  final dynamic id;
  final dynamic name;
  final dynamic isIndiviual;
  final dynamic phoneNumber;
  final dynamic time;
  final dynamic userName;
  dynamic imageUrl = [];
  NewUser({
    @required this.id,
    @required this.name,
    this.isIndiviual,
    this.time,
    this.userName,
    @required this.imageUrl,
    this.phoneNumber,
  });
  factory NewUser.fromDocument(DocumentSnapshot doc) {
    return NewUser(
      id: doc['userId'],
      phoneNumber: doc['phoneNumber'],
      isIndiviual: doc['isIndiviual'],
      time: doc['timestamp'],
      name: doc['userName'],
      imageUrl: doc['Pictures'] != null
          ? List.generate(doc['Pictures'].length, (index) {
              return doc['Pictures'][index];
            })
          : [],
    );
  }
}
