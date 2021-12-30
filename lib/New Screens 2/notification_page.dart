


import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cns/widget/messaging_widget.dart';

class NotificationPage extends StatelessWidget {
  final String appTitle = 'Firebase messaging';
  @override
  Widget build(BuildContext context) {
    return MainPage(appTitle: "Hi");
  }

}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({required this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Notifications"),
      backgroundColor: Color(0xff01b4c9),
    ),
    body: MessagingWidget(),
  );
}

