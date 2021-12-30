import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/Welcome_homepage.dart';
import 'package:cns/Screens/auth/otp.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';

class LoginNgo extends StatefulWidget {
  @override
  _LoginNgoState createState() => _LoginNgoState();
}

class _LoginNgoState extends State<LoginNgo> {
  TextEditingController namengo = TextEditingController();
  TextEditingController addressngo = TextEditingController();
  TextEditingController ownername = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final Shader linearGradient = LinearGradient(
  //   colors: <Color>[
  //     Color(0xfffe6e73),
  //     Color(0xffffb091),
  //   ],
  // ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Continue Registering",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Center(
                child: Text(
                  "As NGO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: namengo,
              //     onChanged: (v) => namengo.text,
              //     decoration: new InputDecoration(
              //       border: new OutlineInputBorder(
              //           borderSide: new BorderSide(color: Colors.teal)),
              //       hintText: 'Enter The Name of NGO',
              //       labelText: 'Name of NGO',
              //       prefixIcon: const Icon(
              //         Icons.home_outlined,
              //         color: Color(0xff01b4c9),
              //       ),
              //       suffixStyle: const TextStyle(color: Colors.green),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 6,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: addressngo,
              //     onChanged: (v) => addressngo.text,
              //     decoration: new InputDecoration(
              //       border: new OutlineInputBorder(
              //           borderSide: new BorderSide(color: Colors.teal)),
              //       hintText: 'Enter address of NGO',
              //       labelText: 'Address',
              //       prefixIcon: const Icon(
              //         Icons.location_on,
              //         color: Color(0xff01b4c9),
              //       ),
              //       suffixStyle: const TextStyle(color: Colors.green),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 6,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: ownername,
              //     onChanged: (v) => ownername.text,
              //     decoration: new InputDecoration(
              //       border: new OutlineInputBorder(
              //           borderSide: new BorderSide(color: Colors.teal)),
              //       hintText: 'Enter the Name of Authorized Person',
              //       labelText: 'Authorized Person',
              //       prefixIcon: const Icon(
              //         Icons.person_rounded,
              //         color: Color(0xff01b4c9),
              //       ),
              //       suffixStyle: const TextStyle(color: Colors.green),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 6,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: email,
              //     onChanged: (v) => email.text,
              //     decoration: new InputDecoration(
              //       border: new OutlineInputBorder(
              //           borderSide: new BorderSide(color: Colors.teal)),
              //       hintText: 'Enter your email',
              //       labelText: 'Email Id',
              //       prefixIcon: const Icon(
              //         Icons.mail,
              //         color: Color(0xff01b4c9),
              //       ),
              //       suffixStyle: const TextStyle(color: Colors.green),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 6,
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: password,
              //     onChanged: (v) => password.text,
              //     decoration: new InputDecoration(
              //       border: new OutlineInputBorder(
              //           borderSide: new BorderSide(color: Colors.teal)),
              //       hintText: 'Enter a Password',
              //       labelText: 'Password',
              //       prefixIcon: const Icon(
              //         Icons.mail,
              //         color: Color(0xff01b4c9),
              //       ),
              //       suffixStyle: const TextStyle(color: Colors.green),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 50,
              // ),
              // InkWell(
              //   onTap: () async {
              //     final dynamic res =
              //         await Provider.of<MainProvider>(context, listen: false)
              //             .emailPasswordLogin(
              //       email.text.toString(),
              //       password.text.toString(),
              //       ownername.text.toString(),
              //       context,
              //       "Ngo",
              //     );
              //     print(res);
              //     if (res == "New User") {
              //       showDialog(
              //           barrierDismissible: false,
              //           context: context,
              //           builder: (_) {
              //             Future.delayed(Duration(seconds: 2), () async {
              //               Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (BuildContext context) =>
              //                       NewScreenSecondHomePage(),
              //                 ),
              //               );
              //             });
              //             return Center(
              //                 child: Container(
              //                     width: 180.0,
              //                     height: 200.0,
              //                     decoration: BoxDecoration(
              //                         color: Colors.white,
              //                         shape: BoxShape.rectangle,
              //                         borderRadius: BorderRadius.circular(20)),
              //                     child: Column(
              //                       children: <Widget>[
              //                         Image.asset(
              //                           "asset/auth/verified.jpg",
              //                           height: 100,
              //                         ),
              //                         Text(
              //                           "Verified\n Successfully",
              //                           textAlign: TextAlign.center,
              //                           style: TextStyle(
              //                               decoration: TextDecoration.none,
              //                               color: Colors.black,
              //                               fontSize: 20),
              //                         )
              //                       ],
              //                     )));
              //           });
              //     } else {
              //       _scaffoldKey.currentState.showSnackBar(SnackBar(
              //         content: Text('Sign In Failed!'),
              //         duration: Duration(seconds: 3),
              //       ));
              //     }
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //         shape: BoxShape.rectangle,
              //         borderRadius: BorderRadius.circular(25),
              //         gradient: LinearGradient(
              //             begin: Alignment.topRight,
              //             end: Alignment.bottomLeft,
              //             colors: [
              //               Color(0xff01b4c9),
              //               Color(0xff01b4c9),
              //             ])),
              //     height: MediaQuery.of(context).size.height * .065,
              //     width: MediaQuery.of(context).size.width * .75,
              //     child: Center(
              //       child: Text(
              //         "Continue",
              //         style: TextStyle(
              //             fontSize: 15,
              //             color: textColor,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ),
              // ),

              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   "OR",
              //   style: TextStyle(fontSize: 18),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final dynamic res = await Provider.of<MainProvider>(
                              context,
                              listen: false)
                          .handleGoogleSignNGO(context, "NGO");
                      if (res == "Success") {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              Future.delayed(Duration(seconds: 1), () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        NewScreenSecondHomePage(),
                                  ),
                                );
                              });
                              return Center(
                                  child: Container(
                                      width: 180.0,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            "asset/auth/verified.jpg",
                                            height: 100,
                                          ),
                                          Text(
                                            "Verified\n Successfully",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: 20),
                                          )
                                        ],
                                      )));
                            });
                      } else {
                        // _scaffoldKey.currentState.showSnackBar(SnackBar(
                        //   content: Text('Sign In Failed!'),
                        //   duration: Duration(seconds: 3),
                        // ));
                      }
                    },
                    child: Image.asset(
                      "asset/google.png",
                      height: 35,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      final dynamic res = await Provider.of<MainProvider>(
                              context,
                              listen: false)
                          .handleFacebookLogin(context);
                      if (res == "Success") {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            Future.delayed(Duration(seconds: 2), () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NewScreenSecondHomePage(),
                                ),
                              );
                            });
                            return Center(
                              child: Container(
                                width: 180.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      "asset/auth/verified.jpg",
                                      height: 100,
                                    ),
                                    Text(
                                      "Verified\n Successfully",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        // _scaffoldKey.currentState.showSnackBar(SnackBar(
                        //   content: Text('$res'),
                        //   duration: Duration(seconds: 3),
                        // ));
                      }
                    },
                    child: Image.asset(
                      "asset/fb.png",
                      height: 45,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      bool updateNumber = false;
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => OTP(updateNumber)));
                    },
                    child: Icon(
                      Icons.message,
                      color: Color(0xff01b4c9),
                      size: 40,
                    ),
                  )
                ],
              ),
             ],
          ),
        ),
      ),
    );
  }
}
