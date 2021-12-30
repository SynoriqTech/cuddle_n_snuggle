import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:cns/util/color.dart';

import 'package:provider/provider.dart';
import 'New Screens 2/Welcome_homepage.dart';
import 'New Screens 2/ngo_or_indiviual.dart';
import 'Screens/Splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutternotificationplugin = FlutterLocalNotificationsPlugin();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialisationAndroid = AndroidInitializationSettings('download');
  var intialisationIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
    (id,String title,String body,String payload) async{});
  var intilisationsetting = InitializationSettings(initialisationAndroid,intialisationIOS);
  await flutternotificationplugin.initialize(intilisationsetting,onSelectNotification: (String payload) async{
    if(payload != null){
      debugPrint('notification payload' + payload);
    }
  });



  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
        ],
        child: new MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isAuth = false;
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future _checkAuth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.currentUser!.then((User user) async {
      print(user);
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .where('userId', isEqualTo: user.uid)
            .get()
            .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.length > 0) {
            if (snapshot.docs[0].data()['location'] != null) {
              setState(() {
                isRegistered = true;
                isLoading = false;
              });
            } else {
              setState(() {
                isAuth = true;
                isLoading = false;
              });
            }
            print("loggedin ${user.uid}");
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    await Provider.of<MainProvider>(context, listen: false).loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: isLoading
          ? Splash()
          : isRegistered
              ? NewScreenSecondHomePage() //NewScreenSecondHomePage()
              : isAuth
                  ? NewScreenSecondHomePage() //NewScreenSecondHomePage()
                  : NgoOrIndiviualPage(),
    );
  }
}
