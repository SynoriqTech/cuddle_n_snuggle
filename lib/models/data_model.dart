import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/models/user_model.dart';

class Notify {
  final User sender;
  final Timestamp time;
  final bool isRead;

  Notify({
    required this.sender,
    required this.time,
    required this.isRead,
  });
}
