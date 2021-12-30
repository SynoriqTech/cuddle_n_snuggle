// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cns/New%20Screens%202/Welcome_homepage.dart';
// import 'package:cns/Screens/auth/otp.dart';
// import 'package:cns/provider/main_provider.dart';
// import 'package:cns/util/color.dart';
// import 'package:provider/provider.dart';
//
// class SignInPage extends StatefulWidget {
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         // title: Text(
//         //   "Cuddles and Snuggles",
//         //   textAlign: TextAlign.center,
//         //   style: TextStyle(
//         //     fontSize: 25,
//         //     color: primaryColor,
//         //     fontWeight: FontWeight.bold,
//         //     fontStyle: FontStyle.normal,
//         //   ),
//         // ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 60),
//             child: Text(
//               "Sign In",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 35,
//                 color: Color(0xff01b4c9),
//                 fontWeight: FontWeight.bold,
//                 fontStyle: FontStyle.normal,
//               ),
//             ),
//           ),
//
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   controller: emailController,
//                   onChanged: (v) => emailController.text,
//                   decoration: new InputDecoration(
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.teal)),
//                     hintText: 'Enter your email',
//                     labelText: 'Email Id',
//                     prefixIcon: const Icon(
//                       Icons.mail,
//                       color: Color(0xff01b4c9),
//                     ),
//                     suffixStyle: const TextStyle(color: Colors.green),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   obscureText: true,
//                   controller: passwordController,
//                   onChanged: (v) => passwordController.text,
//                   decoration: new InputDecoration(
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.teal)),
//                     hintText: 'Enter your password',
//                     labelText: 'Password',
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: Color(0xff01b4c9),
//                     ),
//                     suffixStyle: const TextStyle(color: Colors.green),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 70,
//               ),
//               InkWell(
//                 onTap: () async {
//                   print("Pressd");
//                   final dynamic res =
//                       await Provider.of<MainProvider>(context, listen: false)
//                           .signinusingemailandpassword(
//                     emailController.text.toString(),
//                     passwordController.text.toString(),
//                   );
//                   print(res);
//                   if (res == "New User") {
//                     showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (_) {
//                         Future.delayed(Duration(seconds: 2), () async {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   NewScreenSecondHomePage(),
//                             ),
//                           );
//                         });
//                         return Center(
//                           child: Container(
//                             width: 180.0,
//                             height: 200.0,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: Column(
//                               children: <Widget>[
//                                 Image.asset(
//                                   "asset/auth/verified.jpg",
//                                   height: 100,
//                                 ),
//                                 Text(
//                                   "Verified\n Successfully",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       decoration: TextDecoration.none,
//                                       color: Colors.black,
//                                       fontSize: 20),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     _scaffoldKey.currentState.showSnackBar(
//                       SnackBar(
//                         content: Text('$res'),
//                         duration: Duration(seconds: 3),
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       borderRadius: BorderRadius.circular(25),
//                       gradient: LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             primaryColor.withOpacity(.5),
//                             primaryColor.withOpacity(.8),
//                             primaryColor,
//                             primaryColor
//                           ])),
//                   height: MediaQuery.of(context).size.height * .065,
//                   width: MediaQuery.of(context).size.width * .75,
//                   child: Center(
//                     child: Text(
//                       "Continue",
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: textColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "OR",
//                 style: TextStyle(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       final dynamic res = await Provider.of<MainProvider>(
//                               context,
//                               listen: false)
//                           .handleGoogleSign(context, "Indiviual");
//                       if (res == "Success") {
//                         showDialog(
//                           barrierDismissible: false,
//                           context: context,
//                           builder: (_) {
//                             Future.delayed(Duration(seconds: 2), () async {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       NewScreenSecondHomePage(),
//                                 ),
//                               );
//                             });
//                             return Center(
//                               child: Container(
//                                 width: 180.0,
//                                 height: 200.0,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.rectangle,
//                                     borderRadius: BorderRadius.circular(20)),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Image.asset(
//                                       "asset/auth/verified.jpg",
//                                       height: 100,
//                                     ),
//                                     Text(
//                                       "Verified\n Successfully",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           decoration: TextDecoration.none,
//                                           color: Colors.black,
//                                           fontSize: 20),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         _scaffoldKey.currentState.showSnackBar(
//                           SnackBar(
//                             content: Text('Sign In Failed!'),
//                             duration: Duration(seconds: 3),
//                           ),
//                         );
//                       }
//                     },
//                     child: Image.asset(
//                       "asset/google.png",
//                       height: 35,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       final dynamic res = await Provider.of<MainProvider>(
//                               context,
//                               listen: false)
//                           .handleFacebookLogin(context);
//                       if (res == "Success") {
//                         showDialog(
//                           barrierDismissible: false,
//                           context: context,
//                           builder: (_) {
//                             Future.delayed(Duration(seconds: 2), () async {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       NewScreenSecondHomePage(),
//                                 ),
//                               );
//                             });
//                             return Center(
//                               child: Container(
//                                 width: 180.0,
//                                 height: 200.0,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.rectangle,
//                                     borderRadius: BorderRadius.circular(20)),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Image.asset(
//                                       "asset/auth/verified.jpg",
//                                       height: 100,
//                                     ),
//                                     Text(
//                                       "Verified\n Successfully",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           decoration: TextDecoration.none,
//                                           color: Colors.black,
//                                           fontSize: 20),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         _scaffoldKey.currentState.showSnackBar(SnackBar(
//                           content: Text('$res'),
//                           duration: Duration(seconds: 3),
//                         ));
//                       }
//                     },
//                     child: Image.asset(
//                       "asset/fb.png",
//                       height: 45,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       bool updateNumber = false;
//                       Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                               builder: (context) => OTP(updateNumber)));
//                     },
//                     child: Icon(
//                       Icons.message,
//                       color: Color(0xff01b4c9),
//                       size: 40,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(15.0),
//               //   child: Text(
//               //     "Please make sure that you enter the information correctly any misleading information related to your organisation can lead to legal conseqences.",
//               //     style: Theme.of(context).textTheme.bodyText1,
//               //     textAlign: TextAlign.center,
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
