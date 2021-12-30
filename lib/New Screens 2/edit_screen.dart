// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:image/image.dart' as i;
// import 'package:flutter/material.dart';
// import 'package:cns/Screens/UpdateLocation.dart';
// import 'package:cns/models/new_user_model.dart';
// import 'package:cns/util/color.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
//
// class EditScreen extends StatefulWidget {
//   final NewUser currentUser;
//
//   const EditScreen({Key key, this.currentUser}) : super(key: key);
//   @override
//   _EditScreenState createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//   final TextEditingController aboutCtlr = new TextEditingController();
//   final TextEditingController companyCtlr = new TextEditingController();
//   final TextEditingController livingCtlr = new TextEditingController();
//   final TextEditingController jobCtlr = new TextEditingController();
//   final TextEditingController universityCtlr = new TextEditingController();
//   bool visibleAge = false;
//   bool visibleDistance = true;
//   RangeValues? ageRange;
//   var showMe = "man";
//
//   Map editInfo = {};
//   @override
//   void initState() {
//     super.initState();
//     print("----------- SHOW ME -------------");
//     print(showMe);
//     currentlocation();
//     ageRange = RangeValues(double.parse("50.00"), (double.parse("100.00")));
//     // aboutCtlr.text = widget.currentUser.editInfo['about'];
//     // companyCtlr.text = widget.currentUser.editInfo['company'];
//     // livingCtlr.text = widget.currentUser.editInfo['living_in'];
//     // universityCtlr.text = widget.currentUser.editInfo['university'];
//     // jobCtlr.text = widget.currentUser.editInfo['job_title'];
//     // setState(() {
//     //   showMe = "man";
//     //   visibleAge = widget.currentUser.editInfo['showMyAge'] ?? false;
//     //   print(widget.currentUser.editInfo["WantToAdopt"]);
//     //   visibleDistance = widget.currentUser.editInfo['DistanceVisible'] ?? true;
//     // });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     print(editInfo.length);
//     if (editInfo.length > 0) {
//       updateData();
//     }
//   }
//
//   void currentlocation() async {
//     var currentLocation = await getLocationCoordinates();
//     setState(() {
//       livingCtlr.text = currentLocation["PlaceName"];
//     });
//   }
//
//   Future updateData() async {
//     // Firestore.instance
//     //     .collection("Users")
//     //     .document(widget.currentUser.id)
//     //     .setData({'editInfo': editInfo, 'age': widget.currentUser.age},
//     //         merge: true);
//   }
//
//   Future source(
//       BuildContext context, currentUser, bool isProfilePicture) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return CupertinoAlertDialog(
//               title: Text(
//                   isProfilePicture ? "Update profile picture" : "Add pictures"),
//               content: Text(
//                 "Select source",
//               ),
//               insetAnimationCurve: Curves.decelerate,
//               actions: currentUser.imageUrl.length < 9
//                   ? <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: GestureDetector(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.photo_camera,
//                                 size: 28,
//                               ),
//                               Text(
//                                 " Camera",
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.black,
//                                     decoration: TextDecoration.none),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             Navigator.pop(context);
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   getImage(ImageSource.camera, context,
//                                       currentUser, isProfilePicture);
//                                   return Center(
//                                       child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white),
//                                   ));
//                                 });
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: GestureDetector(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.photo_library,
//                                 size: 28,
//                               ),
//                               Text(
//                                 " Gallery",
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.black,
//                                     decoration: TextDecoration.none),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             Navigator.pop(context);
//                             showDialog(
//                                 barrierDismissible: false,
//                                 context: context,
//                                 builder: (context) {
//                                   getImage(ImageSource.gallery, context,
//                                       currentUser, isProfilePicture);
//                                   return Center(
//                                       child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white),
//                                   ));
//                                 });
//                           },
//                         ),
//                       ),
//                     ]
//                   : [
//                       Padding(
//                         padding: const EdgeInsets.all(25.0),
//                         child: Center(
//                             child: Column(
//                           children: <Widget>[
//                             Icon(Icons.error),
//                             Text(
//                               "Can't uplaod more than 9 pictures",
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                   decoration: TextDecoration.none),
//                             ),
//                           ],
//                         )),
//                       )
//                     ]);
//         });
//   }
//
//   Future getImage(
//       ImageSource imageSource, context, currentUser, isProfilePicture) async {
//     var image = await ImagePicker.pickImage(source: imageSource);
//     if (image != null) {
//       File croppedFile = await ImageCropper.cropImage(
//           sourcePath: image.path,
//           cropStyle: CropStyle.circle,
//           aspectRatioPresets: [CropAspectRatioPreset.square],
//           androidUiSettings: AndroidUiSettings(
//               toolbarTitle: 'Crop',
//               toolbarColor: primaryColor,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.square,
//               lockAspectRatio: true),
//           iosUiSettings: IOSUiSettings(
//             minimumAspectRatio: 1.0,
//           ));
//       if (croppedFile != null) {
//         await uploadFile(
//             await compressimage(croppedFile), currentUser, isProfilePicture);
//       }
//     }
//     Navigator.pop(context);
//   }
//
//   Future uploadFile(File image, NewUser currentUser, isProfilePicture) async {
//     Reference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('users/${currentUser.id}/${image.hashCode}.jpg');
//     UploadTask uploadTask = storageReference.putFile(image);
//     if (uploadTask.isInProgress == true) {}
//     if (await uploadTask.onComplete != null) {
//       storageReference.getDownloadURL().then((fileURL) async {
//         Map<String, dynamic> updateObject = {
//           "Pictures": FieldValue.arrayUnion([
//             fileURL,
//           ])
//         };
//         try {
//           if (isProfilePicture) {
//             //currentUser.imageUrl.removeAt(0);
//             currentUser.imageUrl.insert(0, fileURL);
//             print("object");
//             await FirebaseFirestore.instance
//                 .collection("Users")
//                 .doc(currentUser.id)
//                 .set({"Pictures": currentUser.imageUrl}, SetOptions(merge: true));
//           } else {
//             await FirebaseFirestore.instance
//                 .collection("Users")
//                 .doc(currentUser.id)
//                 .set(updateObject, SetOptions(merge: true));
//             widget.currentUser.imageUrl.add(fileURL);
//           }
//           if (mounted) setState(() {});
//         } catch (err) {
//           print("Error: $err");
//         }
//       });
//     }
//   }
//
//   Future compressimage(File image) async {
//     final tempdir = await getTemporaryDirectory();
//     final path = tempdir.path;
//     i.Image imagefile = i.decodeImage(image.readAsBytesSync());
//     final compressedImagefile = File('$path.jpg')
//       ..writeAsBytesSync(i.encodeJpg(imagefile, quality: 80));
//     // setState(() {
//     return compressedImagefile;
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Profile _profile = new Profile(widget.currentUser);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           elevation: 0,
//           title: Text(
//             "Edit Profile",
//             style: TextStyle(color: Colors.black),
//           ),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             color: Colors.black,
//             onPressed: () => Navigator.pop(context),
//           ),
//           backgroundColor: Color(0xff0e289f)),
//       body: Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50), topRight: Radius.circular(50)),
//               color: Colors.white),
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(50), topRight: Radius.circular(50)),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.center,
//                     height: MediaQuery.of(context).size.height * .65,
//                     width: MediaQuery.of(context).size.width,
//                     child: GridView.count(
//                         physics: NeverScrollableScrollPhysics(),
//                         crossAxisCount: 3,
//                         childAspectRatio:
//                             MediaQuery.of(context).size.aspectRatio * 1.5,
//                         crossAxisSpacing: 4,
//                         padding: EdgeInsets.all(10),
//                         children: List.generate(9, (index) {
//                           return Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Container(
//                                 decoration: widget.currentUser.imageUrl.length >
//                                         index
//                                     ? BoxDecoration()
//                                     : BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(
//                                             style: BorderStyle.solid,
//                                             width: 1,
//                                             color: secondryColor)),
//                                 child: Stack(
//                                   children: <Widget>[
//                                     widget.currentUser.imageUrl.length > index
//                                         ? CachedNetworkImage(
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 .2,
//                                             fit: BoxFit.cover,
//                                             imageUrl: widget.currentUser
//                                                     .imageUrl[index] ??
//                                                 '',
//                                             placeholder: (context, url) =>
//                                                 Center(
//                                               child: CupertinoActivityIndicator(
//                                                 radius: 10,
//                                               ),
//                                             ),
//                                             errorWidget:
//                                                 (context, url, error) => Center(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: <Widget>[
//                                                   Icon(
//                                                     Icons.error,
//                                                     color: Colors.black,
//                                                     size: 25,
//                                                   ),
//                                                   Text(
//                                                     "Enable to load",
//                                                     style: TextStyle(
//                                                       color: Colors.black,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           )
//                                         : Container(),
//                                     Align(
//                                       alignment: Alignment.bottomRight,
//                                       child: Container(
//                                           // width: 12,
//                                           // height: 16,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: widget.currentUser.imageUrl
//                                                         .length >
//                                                     index
//                                                 ? Colors.white
//                                                 : primaryColor,
//                                           ),
//                                           child: widget.currentUser.imageUrl
//                                                       .length >
//                                                   index
//                                               ? InkWell(
//                                                   child: Icon(
//                                                     Icons.cancel,
//                                                     color: primaryColor,
//                                                     size: 22,
//                                                   ),
//                                                   onTap: () async {
//                                                     if (widget.currentUser
//                                                             .imageUrl.length >
//                                                         1) {
//                                                       _deletePicture(index);
//                                                     } else {
//                                                       source(
//                                                           context,
//                                                           widget.currentUser,
//                                                           true);
//                                                     }
//                                                   },
//                                                 )
//                                               : InkWell(
//                                                   child: Icon(
//                                                     Icons.add_circle_outline,
//                                                     size: 22,
//                                                     color: Colors.white,
//                                                   ),
//                                                   onTap: () => source(
//                                                       context,
//                                                       widget.currentUser,
//                                                       false),
//                                                 )),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         })),
//                   ),
//                   InkWell(
//                     child: Container(
//                         decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(25),
//                             gradient: LinearGradient(
//                                 begin: Alignment.topRight,
//                                 end: Alignment.bottomLeft,
//                                 colors: [
//                                   primaryColor.withOpacity(.5),
//                                   primaryColor.withOpacity(.8),
//                                   primaryColor,
//                                   primaryColor,
//                                 ])),
//                         height: 50,
//                         width: 340,
//                         child: Center(
//                             child: Text(
//                           "Add Some photos of Yours",
//                           style: TextStyle(
//                               fontSize: 15,
//                               color: textColor,
//                               fontWeight: FontWeight.bold),
//                         ))),
//                     onTap: () async {
//                       await source(context, widget.currentUser, false);
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Divider(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListBody(
//                       mainAxis: Axis.vertical,
//                       children: <Widget>[
//                         // ListTile(
//                         //   title: Text(
//                         //     "About ${widget.currentUser.name}",
//                         //     style: TextStyle(
//                         //         fontWeight: FontWeight.w500,
//                         //         fontSize: 16,
//                         //         color: Colors.black87),
//                         //   ),
//                         //   subtitle: CupertinoTextField(
//                         //     controller: aboutCtlr,
//                         //     cursorColor: primaryColor,
//                         //     maxLines: 10,
//                         //     minLines: 3,
//                         //     placeholder: "About your pet",
//                         //     padding: EdgeInsets.all(10),
//                         //     onChanged: (text) {
//                         //       editInfo.addAll({'about': text});
//                         //     },
//                         //   ),
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.all(0.1),
//                           child: Padding(
//                             padding: const EdgeInsets.all(0.1),
//                             // child: ListTile(
//                             //   title: Text(
//                             //     "Age range",
//                             //     style: TextStyle(
//                             //         fontSize: 18,
//                             //         color: primaryColor,
//                             //         fontWeight: FontWeight.w500),
//                             //   ),
//                             //   trailing: Text(
//                             //     "${ageRange.start.round()}-${ageRange.end.round()}",
//                             //     style: TextStyle(fontSize: 16),
//                             //   ),
//                             //   subtitle: RangeSlider(
//                             //       inactiveColor: secondryColor,
//                             //       values: ageRange,
//                             //       min: 18.0,
//                             //       max: 100.0,
//                             //       divisions: 25,
//                             //       activeColor: primaryColor,
//                             //       labels: RangeLabels(
//                             //           '${ageRange.start.round()}',
//                             //           '${ageRange.end.round()}'),
//                             //       onChanged: (val) {
//                             //         // changeValues.addAll({
//                             //         //   'age_range': {
//                             //         //     'min': '${val.start.truncate()}',
//                             //         //     'max': '${val.end.truncate()}'
//                             //         //   }
//                             //         // });
//                             //         setState(() {
//                             //           ageRange = val;
//                             //         });
//                             //       }),
//                             // ),
//                           ),
//                         ),
//                         // ListTile(
//                         //   title: Text(
//                         //     "Job title",
//                         //     style: TextStyle(
//                         //         fontWeight: FontWeight.w500,
//                         //         fontSize: 16,
//                         //         color: Colors.black87),
//                         //   ),
//                         //   subtitle: CupertinoTextField(
//                         //     controller: jobCtlr,
//                         //     cursorColor: primaryColor,
//                         //     placeholder: "Add job title",
//                         //     padding: EdgeInsets.all(10),
//                         //     onChanged: (text) {
//                         //       editInfo.addAll({'job_title': text});
//                         //     },
//                         //   ),
//                         // ),
//                         // ListTile(
//                         //   title: Text(
//                         //     "Company",
//                         //     style: TextStyle(
//                         //         fontWeight: FontWeight.w500,
//                         //         fontSize: 16,
//                         //         color: Colors.black87),
//                         //   ),
//                         //   subtitle: CupertinoTextField(
//                         //     controller: companyCtlr,
//                         //     cursorColor: primaryColor,
//                         //     placeholder: "Add company",
//                         //     padding: EdgeInsets.all(10),
//                         //     onChanged: (text) {
//                         //       editInfo.addAll({'company': text});
//                         //     },
//                         //   ),
//                         // ),
//                         // ListTile(
//                         //   title: Text(
//                         //     "University",
//                         //     style: TextStyle(
//                         //         fontWeight: FontWeight.w500,
//                         //         fontSize: 16,
//                         //         color: Colors.black87),
//                         //   ),
//                         //   subtitle: CupertinoTextField(
//                         //     controller: universityCtlr,
//                         //     cursorColor: primaryColor,
//                         //     placeholder: "Add university",
//                         //     padding: EdgeInsets.all(10),
//                         //     onChanged: (text) {
//                         //       editInfo.addAll({'university': text});
//                         //     },
//                         //   ),
//                         // ),
//                         ListTile(
//                           title: Text(
//                             "Current Location",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16,
//                                 color: Colors.black87),
//                           ),
//                           trailing: Icon(
//                             Icons.location_on,
//                             size: 35,
//                           ),
//                           // onTap: () async {
//                           //   var address = await Navigator.push(
//                           //       context,
//                           //       MaterialPageRoute(
//                           //           builder: (context) => UpdateLocation()));
//                           //   print(address);
//                           //   if (address != null) {
//                           //     _updateAddress(address);
//                           //   }
//                           // },
//                           subtitle: CupertinoTextField(
//                             controller: livingCtlr,
//                             cursorColor: primaryColor,
//                             placeholder: "Add city",
//                             padding: EdgeInsets.all(10),
//                             onChanged: (text) {
//                               editInfo.addAll({'living_in': text});
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         ListTile(
//                             title: Text(
//                               "Control your profile",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 16,
//                                   color: Colors.black87),
//                             ),
//                             subtitle: Card(
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   // Row(
//                                   //   mainAxisAlignment:
//                                   //       MainAxisAlignment.spaceBetween,
//                                   //   children: <Widget>[
//                                   //     Padding(
//                                   //       padding: const EdgeInsets.all(8.0),
//                                   //       child: Text("Don't Show My Age"),
//                                   //     ),
//                                   //     Switch(
//                                   //         activeColor: primaryColor,
//                                   //         value: visibleAge,
//                                   //         onChanged: (value) {
//                                   //           editInfo
//                                   //               .addAll({'showMyAge': value});
//                                   //           setState(() {
//                                   //             visibleAge = value;
//                                   //           });
//                                   //         })
//                                   //   ],
//                                   // ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text("Make My Distance Visible"),
//                                       ),
//                                       Switch(
//                                           activeColor: primaryColor,
//                                           value: visibleDistance,
//                                           onChanged: (value) {
//                                             editInfo.addAll(
//                                                 {'DistanceVisible': value});
//                                             setState(() {
//                                               visibleDistance = value;
//                                             });
//                                           })
//                                     ],
//                                   ),
//                                   // Row(
//                                   //   mainAxisAlignment:
//                                   //       MainAxisAlignment.spaceBetween,
//                                   //   children: <Widget>[
//                                   //     Padding(
//                                   //       padding: const EdgeInsets.all(8.0),
//                                   //       child: Text(
//                                   //           "Want your pet to register for adoption"),
//                                   //     ),
//                                   //     Switch(
//                                   //         activeColor: primaryColor,
//                                   //         value: visibleDistance,
//                                   //         onChanged: (value) {
//                                   //           editInfo.addAll(
//                                   //               {'DistanceVisible': value});
//                                   //           setState(() {
//                                   //             visibleDistance = value;
//                                   //           });
//                                   //         })
//                                   //   ],
//                                   // ),
//                                 ],
//                               ),
//                             )),
//                         SizedBox(
//                           height: 100,
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _deletePicture(index) async {
//     if (widget.currentUser.imageUrl[index] != null) {
//       try {
//         Reference _ref = await FirebaseStorage.instance
//             .getReferenceFromUrl(widget.currentUser.imageUrl[index]);
//         print(_ref.path);
//         await _ref.delete();
//       } catch (e) {
//         print(e);
//       }
//     }
//     setState(() {
//       widget.currentUser.imageUrl.removeAt(index);
//     });
//     var temp = [];
//     temp.add(widget.currentUser.imageUrl);
//     await FirebaseFirestore.instance
//         .collection("Users")
//         .doc("${widget.currentUser.id}")
//         .set({"Pictures": temp[0]},SetOptions(merge: true));
//   }
//
//   void _updateAddress(Map _address) {
//     showCupertinoModalPopup(
//         context: context,
//         builder: (ctx) {
//           return Container(
//             color: Colors.white,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * .4,
//             child: Column(
//               children: <Widget>[
//                 Material(
//                   child: ListTile(
//                     title: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'New address:',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             decoration: TextDecoration.none),
//                       ),
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(
//                         Icons.cancel,
//                         color: Colors.black26,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     subtitle: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           _address['PlaceName'] ?? '',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300,
//                               decoration: TextDecoration.none),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 RaisedButton(
//                   color: Colors.white,
//                   child: Text(
//                     "Confirm",
//                     style: TextStyle(color: primaryColor),
//                   ),
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     await FirebaseFirestore.instance
//                         .collection("Users")
//                         .doc('${widget.currentUser.id}')
//                         .updateData({
//                           'location': {
//                             'latitude': _address['latitude'],
//                             'longitude': _address['longitude'],
//                             'address': _address['PlaceName']
//                           },
//                         })
//                         .whenComplete(() => showDialog(
//                             barrierDismissible: false,
//                             context: context,
//                             builder: (_) {
//                               Future.delayed(Duration(seconds: 3), () {
//                                 setState(() {
//                                   // widget.currentUser.address =
//                                   //     _address['PlaceName'];
//                                 });
//
//                                 Navigator.pop(context);
//                               });
//                               return Center(
//                                   child: Container(
//                                       width: 160.0,
//                                       height: 120.0,
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.rectangle,
//                                           borderRadius:
//                                               BorderRadius.circular(20)),
//                                       child: Column(
//                                         children: <Widget>[
//                                           Image.asset(
//                                             "asset/auth/verified.jpg",
//                                             height: 60,
//                                             color: primaryColor,
//                                             colorBlendMode: BlendMode.color,
//                                           ),
//                                           Text(
//                                             "location\nchanged",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 decoration: TextDecoration.none,
//                                                 color: Colors.black,
//                                                 fontSize: 20),
//                                           )
//                                         ],
//                                       )));
//                             }))
//                         .catchError((e) {
//                           print(e);
//                         });
//
//                     // .then((_) {
//                     //   Navigator.pop(context);
//                     // });
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }
