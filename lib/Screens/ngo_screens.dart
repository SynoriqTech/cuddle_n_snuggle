// import 'package:flutter/material.dart';
// import 'package:cns/Screens/Ngo_deatils.dart';
// import 'package:cns/Screens/auth/login.dart';
// import 'package:cns/util/color.dart';

// class NgoScreen extends StatefulWidget {
//   @override
//   _NgoScreenState createState() => _NgoScreenState();
// }

// class _NgoScreenState extends State<NgoScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               "asset/ngopagephoto.jpg",
//               height: 250,
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NgoDetails(),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(25),
//                     gradient: LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomLeft,
//                         colors: [
//                           primaryColor.withOpacity(.5),
//                           primaryColor.withOpacity(.8),
//                           primaryColor,
//                           primaryColor
//                         ])),
//                 height: MediaQuery.of(context).size.height * .065,
//                 width: MediaQuery.of(context).size.width * .75,
//                 child: Center(
//                   child: Text(
//                     "Signup as NGO",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: textColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => Login()));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(25),
//                     gradient: LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomLeft,
//                         colors: [
//                           primaryColor.withOpacity(.5),
//                           primaryColor.withOpacity(.8),
//                           primaryColor,
//                           primaryColor
//                         ])),
//                 height: MediaQuery.of(context).size.height * .065,
//                 width: MediaQuery.of(context).size.width * .75,
//                 child: Center(
//                   child: Text(
//                     "Signup as Indiviual",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: textColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
