import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cns/New%20Screens%202/LoginNgo.dart';
import 'package:cns/New%20Screens%202/register_as_indiviual.dart';

class NgoOrIndiviualPage extends StatefulWidget {
  @override
  _NgoOrIndiviualPageState createState() => _NgoOrIndiviualPageState();
}

class _NgoOrIndiviualPageState extends State<NgoOrIndiviualPage> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xff01b4c9),
      Color(0xff01b4c9),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome\tTo",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Text(
                        "Cuddles and Snuggles",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 34,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    Text(
                      "How would you like to continue?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(
                        child: TextButton(
                          child: Text("Continue As NGO".toUpperCase(),
                              style: GoogleFonts.nunito(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Color(0xffd3bc96))))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginNgo()));
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          child: Text(
                            "Continue as Individual".toUpperCase(),
                            style: GoogleFonts.nunito(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff01b4c9)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color(0xff01b4c9))))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RegisterIndiviual()));
                          },
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 15,
                    ),

                    // ElevatedButton(
                    //   child: Text(
                    //       "Continue To Log In".toUpperCase(),
                    //       style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.w600)
                    //   ),
                    //   style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all<Color>(Color(0xff01b4c9)),
                    //       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(18.0),
                    //               side: BorderSide(color: Color(0xff01b4c9))
                    //           )
                    //       )
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //                 SignInPage()));
                    //   },
                    // ),
                    //
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //                 RegisterIndiviual()));
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.rectangle,
                    //         borderRadius: BorderRadius.circular(25),
                    //         gradient: LinearGradient(
                    //             begin: Alignment.topRight,
                    //             end: Alignment.bottomLeft,
                    //             colors: [
                    //               Color(0xfffe6e73),
                    //               Color(0xffffb091),
                    //             ])),
                    //     height: MediaQuery.of(context).size.height * .065,
                    //     width: MediaQuery.of(context).size.width * .75,
                    //     child: Center(
                    //       child: Text(
                    //         "Signup as Indiviual",
                    //         style: TextStyle(
                    //             fontSize: 15,
                    //             color: textColor,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //                 SignInPage()));
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.rectangle,
                    //         borderRadius: BorderRadius.circular(25),
                    //         gradient: LinearGradient(
                    //             begin: Alignment.topRight,
                    //             end: Alignment.bottomLeft,
                    //             colors: [
                    //               Color(0xfffe6e73),
                    //               Color(0xffffb091),
                    //             ])),
                    //     height: MediaQuery.of(context).size.height * .065,
                    //     width: MediaQuery.of(context).size.width * .75,
                    //     child: Center(
                    //       child: Text(
                    //         "SignIn",
                    //         style: TextStyle(
                    //             fontSize: 15,
                    //             color: textColor,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 120,
                    ),
                    Column(
                      children: [
                        Text(
                          "Before continuing make sure you have read our",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .merge(TextStyle()),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          " Terms & Condition and Privacy Policy",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .merge(TextStyle(fontWeight: FontWeight.w700)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
