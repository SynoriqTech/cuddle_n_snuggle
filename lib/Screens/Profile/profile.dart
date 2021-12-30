// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cns/Screens/Information.dart';
// import 'package:cns/Screens/Profile/EditProfile.dart';
// import 'package:cns/Screens/Profile/settings.dart';
// import 'package:cns/models/user_model.dart';
// import 'package:cns/util/color.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// final List adds = [
//   {
//     'icon': Icons.whatshot,
//     'color': Colors.indigo,
//     'title': "Get matches faster",
//     'subtitle': "Boost your profile once a month",
//   },
//   {
//     'icon': Icons.favorite,
//     'color': Colors.lightBlueAccent,
//     'title': "more likes",
//     'subtitle': "Get free rewindes",
//   },
//   {
//     'icon': Icons.star_half,
//     'color': Colors.amber,
//     'title': "Increase your chances",
//     'subtitle': "Get unlimited free likes",
//   },
//   {
//     'icon': Icons.location_on,
//     'color': Colors.purple,
//     'title': "Swipe around the world",
//     'subtitle': "Passport to anywhere with hookup4u",
//   },
//   {
//     'icon': Icons.vpn_key,
//     'color': Colors.orange,
//     'title': "Control your profile",
//     'subtitle': "highly secured",
//   }
// ];

// class Profile extends StatefulWidget {
//   final User currentUser;
//   final bool isPuchased;
//   final Map items;
//   final List<PurchaseDetails> purchases;
//   Profile(this.currentUser, this.isPuchased, this.purchases, this.items);

//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   final EditProfileState _editProfileState = EditProfileState();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(50), topRight: Radius.circular(50)),
//             color: Colors.white),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 10,
//               ),
//               Hero(
//                 tag: "abc",
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CircleAvatar(
//                     radius: 80,
//                     backgroundColor: secondryColor,
//                     child: Material(
//                       color: Colors.white,
//                       child: Stack(
//                         children: <Widget>[
//                           InkWell(
//                             onTap: () => showDialog(
//                                 barrierDismissible: false,
//                                 context: context,
//                                 builder: (context) {
//                                   return Info(widget.currentUser,
//                                       widget.currentUser, null);
//                                 }),
//                             child: Center(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(
//                                   80,
//                                 ),
//                                 child: CachedNetworkImage(
//                                   height: 150,
//                                   width: 150,
//                                   fit: BoxFit.fill,
//                                   imageUrl:
//                                       widget.currentUser.imageUrl.length > 0
//                                           ? widget.currentUser.imageUrl[0] ?? ''
//                                           : '',
//                                   useOldImageOnUrlChange: true,
//                                   placeholder: (context, url) =>
//                                       CupertinoActivityIndicator(
//                                     radius: 15,
//                                   ),
//                                   errorWidget: (context, url, error) => Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Icon(
//                                         Icons.error,
//                                         color: Colors.black,
//                                         size: 30,
//                                       ),
//                                       Text(
//                                         "Enable to load",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30)),
//                               color: primaryColor,
//                               child: IconButton(
//                                   alignment: Alignment.center,
//                                   icon: Icon(
//                                     Icons.photo_camera,
//                                     size: 25,
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: () {
//                                     _editProfileState.source(
//                                         context, widget.currentUser, true);
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 widget.currentUser.name != null &&
//                         widget.currentUser.age != null
//                     ? "${widget.currentUser.name}, ${widget.currentUser.age}"
//                     : "",
//                 style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 30),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * .45,
//                 child: Stack(
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(top: 60),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               height: 70,
//                               width: 70,
//                               child: FloatingActionButton(
//                                   heroTag: UniqueKey(),
//                                   splashColor: secondryColor,
//                                   backgroundColor: primaryColor,
//                                   child: Icon(
//                                     Icons.add_a_photo,
//                                     color: Colors.white,
//                                     size: 32,
//                                   ),
//                                   onPressed: () {
//                                     _editProfileState.source(
//                                         context, widget.currentUser, false);
//                                   }),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 "Add media",
//                                 style: TextStyle(color: secondryColor),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.only(left: 30, top: 30),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Column(
//                             children: <Widget>[
//                               FloatingActionButton(
//                                   splashColor: secondryColor,
//                                   heroTag: UniqueKey(),
//                                   backgroundColor: Colors.white,
//                                   child: Icon(
//                                     Icons.settings,
//                                     color: secondryColor,
//                                     size: 28,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         CupertinoPageRoute(
//                                             maintainState: true,
//                                             builder: (context) => Settings(
//                                                 currentUser : widget.currentUser,
//                                                 )));
//                                   }),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Settings",
//                                   style: TextStyle(color: secondryColor),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )),
//                     Padding(
//                         padding: const EdgeInsets.only(right: 30, top: 30),
//                         child: Align(
//                           alignment: Alignment.centerRight,
//                           child: Column(
//                             children: <Widget>[
//                               FloatingActionButton(
//                                   heroTag: UniqueKey(),
//                                   splashColor: secondryColor,
//                                   backgroundColor: Colors.white,
//                                   child: Icon(
//                                     Icons.edit,
//                                     color: secondryColor,
//                                     size: 28,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         CupertinoPageRoute(
//                                             builder: (context) => EditProfile(
//                                                 widget.currentUser)));
//                                   }),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Edit Info",
//                                   style: TextStyle(color: secondryColor),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 210),
//                       child: Container(
//                         height: 120,
//                         child: CustomPaint(
//                           painter: CurvePainter(),
//                           size: Size.infinite,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CurvePainter extends CustomPainter {
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint();

//     paint.color = secondryColor.withOpacity(.4);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 1.5;

//     var startPoint = Offset(0, -size.height / 2);
//     var controlPoint1 = Offset(size.width / 4, size.height / 3);
//     var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
//     var endPoint = Offset(size.width, -size.height / 2);

//     var path = Path();
//     path.moveTo(startPoint.dx, startPoint.dy);
//     path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
//         controlPoint2.dy, endPoint.dx, endPoint.dy);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
