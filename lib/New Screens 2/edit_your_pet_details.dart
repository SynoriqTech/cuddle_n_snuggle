import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/Welcome_homepage.dart';
import 'package:cns/models/pets.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:cns/util/color.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  final PetsModel e;
  final String documentId;
  const EditProfile({Key? key, required this.e, required this.documentId}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _switchValue = true;
  bool _switchValue2 = true;
  @override
  void initState() {
    super.initState();
  }

  

  File? image;
  Future source(
      BuildContext context, currentUser, bool isProfilePicture) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
                isProfilePicture ? "Update profile picture" : "Add pictures"),
            content: Text(
              "Select source",
            ),
            insetAnimationCurve: Curves.decelerate,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.photo_camera,
                        size: 28,
                      ),
                      Text(
                        " Camera",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          getImage(ImageSource.camera, context, currentUser,
                              isProfilePicture);
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ));
                        });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.photo_library,
                        size: 28,
                      ),
                      Text(
                        " Gallery",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          getImage(ImageSource.gallery, context, currentUser,
                              isProfilePicture);
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ));
                        });
                  },
                ),
              ),
            ],
          );
        });
  }

  Future uploadFile(
      File image, User currentUser, isProfilePicture) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${currentUser.uid}/${image.hashCode}.jpg');
    UploadTask uploadTask = storageReference.putFile(image);
    // if (uploadTask.isInProgress == true) {}

      storageReference.getDownloadURL().then((fileURL) async {
        Map<String, dynamic> updateObject = {
          "image": FieldValue.arrayUnion([
            fileURL,
          ])
        };
        try {
          await FirebaseFirestore.instance
              .collection("Users/${currentUser.uid}/Pets")
              .doc(widget.documentId)
              .set(updateObject, SetOptions(merge: true));
          await Provider.of<MainProvider>(context, listen: false).getPets();
          if (mounted) setState(() {});
        } catch (err) {
          print("Error: $err");
        }
      });

  }

  Future getImage(
      ImageSource imageSource, context, currentUser, isProfilePicture) async {
    var image = await ImagePicker().getImage(source: imageSource);
    if (image != null) {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        setState(() {
          croppedFile = image as File;
        });

        final FirebaseAuth _auth = FirebaseAuth.instance;
        User currentUser = await _auth.currentUser!;
        uploadFile(new File(image.path), currentUser, isProfilePicture);
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewScreenSecondHomePage()));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .065,
          width: MediaQuery.of(context).size.width * .55,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // borderRadius: BorderRadius.circular(25),
              color: Color(0xff01b4c9),
            ),
            height: MediaQuery.of(context).size.height * .065,
            width: MediaQuery.of(context).size.width * .55,
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 15,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("Edit Your Pet Details"),
            Consumer<MainProvider>(
              builder: (_, pet, __) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * .65,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              childAspectRatio:
                                  MediaQuery.of(context).size.aspectRatio * 1.5,
                              crossAxisSpacing: 4,
                              padding: EdgeInsets.all(10),
                              children: List.generate(9, (index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: secondryColor,
                                        ),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          widget.e.imageUrl.length > index
                                              ? CachedNetworkImage(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                .2,
                                                  useOldImageOnUrlChange: true,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CupertinoActivityIndicator(
                                                      radius: 10,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.error,
                                                        color: Colors.black,
                                                        size: 30,
                                                      ),
                                                      Text(
                                                        "Enable to load",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  imageUrl: widget.e.imageUrl[0]
                                                      .toString(),
                                                )
                                              : Container(),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff01b4c9),
                                              ),
                                              child: InkWell(
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  size: 22,
                                                  color: Colors.white,
                                                ),
                                                onTap: () => source(
                                                  context,
                                                  "widget.currentUser",
                                                  false,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pets Name",
                                style: GoogleFonts.nunito(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                                Text(
                                  widget.e.petName.toString(),
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pets Age",
                                style: GoogleFonts.nunito(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),

                              Text(
                                widget.e.age.toString() + " years",
                                style: GoogleFonts.nunito(fontSize: 20,
                                fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pets Category",
                                style: GoogleFonts.nunito(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                widget.e.category.toString(),
                                style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SubCategory",
                                style: GoogleFonts.nunito(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              
                              Text(
                                widget.e.subcategory.toString(),
                                style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 8.0,
                          shadowColor: Colors.black,
                          child: Container(
                            height: 130.0,
                            width: 450.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),

                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        new Text(
                                          widget.e.petName.toString(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          textAlign: TextAlign.start,),
                                        new Text(
                                          widget.e.age.toString() + " years",
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          textAlign: TextAlign.start,),

                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        new Text(
                                          widget.e.category.toString(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          textAlign: TextAlign.start,),
                                        new Text(
                                          widget.e.subcategory.toString(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          textAlign: TextAlign.center,),
                                        new Text(
                                          widget.e.sex.toString(),
                                          style:TextStyle(color: Colors.black,fontSize: 22),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ],
                                ),


                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "About Your Pet",
                          style: GoogleFonts.nunito(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          height: 5 * 18.0,
                          child: TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: "Describe About Your Pet Here",
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Vaccinated"),
                            SizedBox(
                              width: 35,
                            ),
                            CupertinoSwitch(
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("KCI Certified"),
                            SizedBox(
                              width: 20,
                            ),
                            CupertinoSwitch(
                              value: _switchValue2,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue2 = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      TextStyle(
                        fontSize: 25,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff01b4c9),
            Color(0xff01b4c9),
          ],
        ),
      ),
    );
  }
}
