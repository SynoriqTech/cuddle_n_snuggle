import 'package:cloud_firestore/cloud_firestore.dart';

class PetsModel {
  final dynamic userId;
  final dynamic id;
  final dynamic petName;
  final dynamic category;
  final dynamic petdob;
  final dynamic subcategory;
  final dynamic sex;
  final dynamic age;
  final dynamic about;
  final dynamic vaccinated;
  final dynamic kssi_certified;
  dynamic imageUrl = [];

  PetsModel({
    this.userId,
    this.about,
    this.age,
    this.vaccinated,
    this.kssi_certified,
    this.id,
    this.petName,
    this.category,
    this.petdob,
    this.subcategory,
    this.sex,
    this.imageUrl,
  });
  factory PetsModel.fromDocument(DocumentSnapshot doc, dynamic documetId) {
    return PetsModel(
      userId: doc['userId'],
      petName: doc['name'],
      category: doc['category'],
      petdob: doc['petdob'],
      sex: doc['sex'],
      subcategory: doc['subcategory'],
      age: ((DateTime.now().difference(DateTime.parse(doc["petdob"])).inDays) /
              365.2425)
          .truncate(),
      about: doc['bio'],
      kssi_certified: doc['kssi_certified'],
      vaccinated: doc['vaccinated'],
      imageUrl: doc['image'] != null
          ? List.generate(
              doc['image'].length,
              (index) {
                return doc['image'][index];
              },
            )
          : [],
      id: documetId.toString(),
    );
  }
}
