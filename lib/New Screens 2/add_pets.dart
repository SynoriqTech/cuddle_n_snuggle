import 'dart:io';
import 'package:cns/New Screens 2/Welcome_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:cns/util/color.dart';
import 'package:image/image.dart' as i;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


enum Pets { dog, cats, fish, hamster, mice, rabbits }

class AddPet extends StatefulWidget {
  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  bool _switchValue = true;
  bool _switchValue2 = true;
  String petType = "dog";
  String _verticalGroupValue = "Male";
  List<String> _status = ["Male", "Female"];
  File? _image;
  var _showMe;
  String save = "Save";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  String? date;
  Pets _site = Pets.dog;
  String? apartment;
  String? block;
  Map<String, dynamic> aparts = {};

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.doc("Params/Categories").get().then((value) {
      this.aparts = Map.of(value['pets'] ?? {});
      if (apartment == null) {
        apartment = aparts.keys.toList().first;
        block = List.of(aparts[aparts.keys.toList().first] ?? []).first;
        print("------- Apartments ----------");
        print(apartment);
      }
      setState(() {});
    });
    _image != null;
    date = "";
  }

  // Widget switchWithString(String petType) {
  //   print(petType);
  //   switch (petType) {
  //     case 'cats':
  //       print(petType);
  //       return DropdownButton(
  //         iconEnabledColor: primaryColor,
  //         iconDisabledColor: secondryColor,
  //         isExpanded: true,
  //         items: [
  //           DropdownMenuItem(
  //             child: Text("German Shepherd"),
  //             value: "German Shepherd",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Bulldog"),
  //             value: "Bulldog",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Poodle"),
  //             value: "Poodle",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Labrador Retriever"),
  //             value: "Labrador Retriever",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Golden Retriever"),
  //             value: "Golden Retriever",
  //           ),
  //         ],
  //         onChanged: (val) {
  //           setState(() {
  //             _showMe = val;
  //           });
  //         },
  //         value: _showMe,
  //       );
  //       break;
  //     case 'dog':
  //       print(petType);
  //       return DropdownButton(
  //         iconEnabledColor: primaryColor,
  //         iconDisabledColor: secondryColor,
  //         isExpanded: true,
  //         items: [
  //           DropdownMenuItem(
  //             child: Text("German Shepherd"),
  //             value: "German Shepherd",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Bulldog"),
  //             value: "Bulldog",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Poodle"),
  //             value: "Poodle",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Labrador Retriever"),
  //             value: "Labrador Retriever",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Golden Retriever"),
  //             value: "Golden Retriever",
  //           ),
  //         ],
  //         onChanged: (val) {
  //           setState(() {
  //             _showMe = val;
  //           });
  //         },
  //         value: _showMe,
  //       );
  //       break;
  //     case 'fish':
  //       print(petType);
  //       return DropdownButton(
  //         iconEnabledColor: primaryColor,
  //         iconDisabledColor: secondryColor,
  //         isExpanded: true,
  //         items: [
  //           DropdownMenuItem(
  //             child: Text("German Shepherd"),
  //             value: "German Shepherd",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Bulldog"),
  //             value: "Bulldog",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Poodle"),
  //             value: "Poodle",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Labrador Retriever"),
  //             value: "Labrador Retriever",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Golden Retriever"),
  //             value: "Golden Retriever",
  //           ),
  //         ],
  //         onChanged: (val) {
  //           setState(() {
  //             _showMe = val;
  //           });
  //         },
  //         value: _showMe,
  //       );
  //       break;
  //     case 'hamster':
  //       print(petType);
  //       return DropdownButton(
  //         iconEnabledColor: primaryColor,
  //         iconDisabledColor: secondryColor,
  //         isExpanded: true,
  //         items: [
  //           DropdownMenuItem(
  //             child: Text("German Shepherd"),
  //             value: "German Shepherd",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Bulldog"),
  //             value: "Bulldog",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Poodle"),
  //             value: "Poodle",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Labrador Retriever"),
  //             value: "Labrador Retriever",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Golden Retriever"),
  //             value: "Golden Retriever",
  //           ),
  //         ],
  //         onChanged: (val) {
  //           setState(() {
  //             _showMe = val;
  //           });
  //         },
  //         value: _showMe,
  //       );
  //       break;
  //     case 'mice':
  //       print(petType);
  //       return DropdownButton(
  //         iconEnabledColor: primaryColor,
  //         iconDisabledColor: secondryColor,
  //         isExpanded: true,
  //         items: [
  //           DropdownMenuItem(
  //             child: Text("German Shepherd"),
  //             value: "German Shepherd",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Bulldog"),
  //             value: "Bulldog",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Poodle"),
  //             value: "Poodle",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Labrador Retriever"),
  //             value: "Labrador Retriever",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Golden Retriever"),
  //             value: "Golden Retriever",
  //           ),
  //         ],
  //         onChanged: (val) {
  //           setState(() {
  //             _showMe = val;
  //           });
  //         },
  //         value: _showMe,
  //       );
  //       break;
  //     case 'Rabbit':
  //       print(petType);
  //       return DropdownButton(
  //         iconEnabledColor: primaryColor,
  //         iconDisabledColor: secondryColor,
  //         isExpanded: true,
  //         items: [
  //           DropdownMenuItem(
  //             child: Text("German Shepherd"),
  //             value: "German Shepherd",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Bulldog"),
  //             value: "Bulldog",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Poodle"),
  //             value: "Poodle",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Labrador Retriever"),
  //             value: "Labrador Retriever",
  //           ),
  //           DropdownMenuItem(
  //             child: Text("Golden Retriever"),
  //             value: "Golden Retriever",
  //           ),
  //         ],
  //         onChanged: (val) {
  //           setState(() {
  //             _showMe = val;
  //           });
  //         },
  //         value: _showMe,
  //       );
  //       break;
  //     default:
  //       return Text("No Pet");
  //   }
  // }

  Future source(BuildContext context, bool isProfilePicture) async {
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
              actions: [
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
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            getImage(
                                ImageSource.camera, context, isProfilePicture);
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
                            getImage(
                                ImageSource.gallery, context, isProfilePicture);
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
              ]);
        });
  }

  Future compressimage(File image) async {
    print("Compress image");
    final tempdir = await getTemporaryDirectory();
    final path = tempdir.path;
    i.Image? imagefile = i.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path.jpg')
      ..writeAsBytesSync(i.encodeJpg(imagefile!, quality: 80));
    return compressedImagefile;
  }

  Future getImage(ImageSource imageSource, context, isProfilePicture) async {
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
          compressimage(File(image.path));
          _image = File(image.path);
        });
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff01b4c9),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          "Add Pets",
          style: Theme.of(context).textTheme.bodyText1!.merge(
                TextStyle(fontSize: 25, color: Colors.white),
              ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    source(context, true);
                  },
                  child: Center(
                      child: _image == null
                          ? CircleAvatar(
                              radius: 50,
                              child: Center(
                                child: Icon(Icons.camera),
                              ),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image!),
                            )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextFormField(
                    controller: nameController,
                    onChanged: (v) => nameController.text,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: 'Enter Your Pets Name',
                      labelText: 'Pets Name',
                      prefixIcon: const Icon(
                        Icons.pets,
                        color: Color(0xff01b4c9),
                      ),
                      suffixStyle: const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2,
                  child: DateTimePicker(
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    dateLabelText: 'Date',
                    onChanged: (val) {
                      setState(() {
                        date = val;
                        print(date);
                      });
                    },
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "What is category of your pet ?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      height: 48,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton(
                        items: aparts.keys
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        value: apartment,
                        isExpanded: true,
                        onChanged: (value) {
                          this.apartment = value as String?;
                          this.block = List.of(aparts[value] ?? []).first ?? "";
                          setState(() {});
                        },
                        underline: SizedBox(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "What is Breed of your pet ?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton(
                      items: List.of(aparts[apartment] ?? [])
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      value: block,
                      onChanged: (value) {
                        this.block = value as String?;
                        setState(() {});
                      },
                      underline: SizedBox(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextFormField(
                    controller: aboutController,
                    onChanged: (v) => aboutController.text,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: 'Describe Your Pet to let the world know',
                      labelText: 'About Your Pet',
                      prefixIcon: const Icon(
                        Icons.message_outlined,
                        color: Color(0xff01b4c9),
                      ),
                      suffixStyle: const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Sex",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: _verticalGroupValue,
                      onChanged: (value) => setState(() {
                        _verticalGroupValue = value!;
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (nameController.text.length == 0 ||
                        date.toString() == "" ||
                        apartment == "" ||
                        block.toString() == "" ||
                        _verticalGroupValue == "") {

                    } else {
                      setState(() {
                        save = "Saving..";
                      });
                      final dynamic res = await Provider.of<MainProvider>(
                        context,
                        listen: false,
                      ).addPetsPublic(
                          nameController.text.toString(),
                          date.toString(),
                          apartment.toString(),
                          _image!,
                          block.toString(),
                          aboutController.text.toString(),
                          _switchValue,
                          _switchValue2,
                          _verticalGroupValue.toString());
                      if (res == "Success") {
                        setState(() {
                          nameController.text = "";
                          date = "";
                          save = "Saved";
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pet Added Successfully'),
                            ),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewScreenSecondHomePage()));
                        });

                      } else {
                        setState(() {
                          save = "Save";
                        });

                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff01b4c9),
                          Color(0xff01b4c9),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * .065,
                    width: MediaQuery.of(context).size.width * .75,
                    child: Center(
                      child: Text(
                        "$save",
                        style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
