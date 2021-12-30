import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:curved_splash_screen/curved_splash_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    load_functions();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void load_functions() async {
    await Provider.of<MainProvider>(context, listen: false).decideSplash();
  }

  final List<Map<String, String>> _splashList = [
    {
      "title": "Start Learning",
      "text":
      "Start learning now by using this app, Get your choosen course and start the journey.",
      "image": "assets/fb.png",
    },
    {
      "title": "Explore Courses",
      "text": "Choose which course is suitable for you to enroll in.",
      "image": "asset/fb.png",
    },
    {
      "title": "At Any time.",
      "text": "Your courses is available at any time you want. Join us now !",
      "image": "asset/fb.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Color(0xff01b4c9),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CurvedSplashScreen(
          screensLength: _splashList.length,
          screenBuilder: (index) {
            return SplashContent(
              key: Key(_splashList[index]["title"]!),
              title: _splashList[index]["title"]!,
              image: _splashList[index]["image"]!,
              text: _splashList[index]["text"]!,
            );
          },
          onSkipButton: () {
            print("Ends");
          }),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  const SplashContent({
    required Key key,
    required this.title,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Container(
            height: 200,
            child: Image.asset(image),
          ),
          SizedBox(height: 60),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
            ),
          )
        ],
      ),
    );
  }
}
