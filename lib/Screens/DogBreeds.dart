// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cns/Screens/UserName.dart';
// import 'package:cns/Screens/pet_age.dart';
// import 'package:cns/util/color.dart';

// class DogBreeds extends StatefulWidget {
//   @override
//   _DogBreedsState createState() => _DogBreedsState();
// }

// class _DogBreedsState extends State<DogBreeds> {
//   List dogBreeds = [
//     "German Shepherd",
//     "Bulldog",
//     "Poodle",
//     "Labrador Retriever",
//     "Golden Retriever"
//   ];
//   dynamic dogBredds = "Golden Retriever";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: AnimatedOpacity(
//         opacity: 1.0,
//         duration: Duration(milliseconds: 50),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: FloatingActionButton(
//             elevation: 10,
//             child: IconButton(
//               color: secondryColor,
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             backgroundColor: Colors.white38,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//       body: Container(
//         padding: EdgeInsets.only(top: 100),
//         child: Center(
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(
//                   dogBreeds[index].toString(),
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 trailing: Icon(Icons.arrow_right_rounded),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                       builder: (context) => UserName(),
//                     ),
//                   );
//                 },
//               );
//             },
//             itemCount: dogBreeds.length,
//           ),
//         ),
//       ),
//     );
//   }
// }
