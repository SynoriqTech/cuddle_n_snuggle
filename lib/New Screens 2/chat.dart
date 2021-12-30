import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/New Screens 2/pet_adoption.dart';
import 'package:cns/New%20Screens%202/Welcome_homepage.dart';

import 'package:cns/Screens/Chat/largeImage.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/util/color.dart';
import 'package:cns/util/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPage extends StatefulWidget {
  final NewUser sender;
  final String chatId;
  final String second_name;
  final String imageUrl;
  final dynamic second_id;
  ChatPage(
      {required this.sender,
      required this.chatId,
      required this.second_name,
      required this.second_id,
      required this.imageUrl});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isBlocked = false;
  final db = FirebaseFirestore.instance;
  CollectionReference? chatReference;
  final TextEditingController _textController = new TextEditingController();
  bool _isWritting = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print("object    -${widget.chatId}");
    super.initState();
    chatReference =
        db.collection("chats").doc(widget.chatId).collection('messages');
    // checkblock();
  }

  // var blockedBy;
  // checkblock() {
  //   chatReference.doc('blocked').snapshots().listen((onData) {
  //     if (onData.data != null) {
  //       blockedBy = onData.data['blockedBy'];
  //       if (onData.data['isBlocked']) {
  //         isBlocked = true;
  //       } else {
  //         isBlocked = false;
  //       }
  //
  //       if (mounted) setState(() {});
  //     }
  //     // print(onData.data['blockedBy']);
  //   });
  // }

  List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      Expanded(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: (documentSnapshot.data() as Map)['image_url'] != ''
                  ? InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(
                          top: 2.0, bottom: 2.0, right: 15),
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            placeholder: (context, url) =>
                                Center(
                                  child: CupertinoActivityIndicator(
                                    radius: 10,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            height:
                            MediaQuery
                                .of(context)
                                .size
                                .height * .65,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .9,
                            imageUrl: (documentSnapshot
                                .data() as Map)['image_url'] ?? '',
                            fit: BoxFit.fitWidth,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: (documentSnapshot.data() as Map)['isRead'] ==
                                false
                                ? Icon(
                              Icons.done,
                              color: secondryColor,
                              size: 15,
                            )
                                : Icon(
                              Icons.done_all,
                              color: primaryColor,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                      height: 150,
                      width: 150.0,
                      color: secondryColor.withOpacity(.5),
                      padding: EdgeInsets.all(5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                          (documentSnapshot.data() as Map)["time"] != null
                              ? DateFormat.yMMMd()
                              .add_jm()
                              .format((documentSnapshot.data() as Map)["time"]
                              .toDate())
                              .toString()
                              : "",
                          style: TextStyle(
                            color: secondryColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          )),
                    )
                  ],
                ),
                onTap: () {
                  ///TODO: Assign new page, seems like a missing one.
                  print("Check TODO of chat.dart");
                  // Navigator.of(context).push(
                  //   CupertinoPageRoute(
                  //     builder: (context) => LargeImage(
                  //       (documentSnapshot.data() as Map)['image_url'],
                  //     ),
                  //   ),
                  // );

                },
              )
                  : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.65,
                  margin: EdgeInsets.only(
                      top: 8.0, bottom: 8.0, left: 80.0, right: 10),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                (documentSnapshot.data() as Map)['text'],
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text((documentSnapshot.data() as Map)["time"] !=
                                  null
                                  ? DateFormat.MMMd()
                                  .add_jm()
                                  .format(
                                  (documentSnapshot.data() as Map)["time"]
                                      .toDate())
                                  .toString()
                                  : "",
                                style: TextStyle(
                                  color: secondryColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              (documentSnapshot.data() as Map)['isRead'] ==
                                  false
                                  ? Icon(
                                Icons.done,
                                color: secondryColor,
                                size: 15,
                              )
                                  : Icon(
                                Icons.done_all,
                                color: primaryColor,
                                size: 15,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ];
  }

  _messagesIsRead(documentSnapshot) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: CircleAvatar(
              backgroundColor: secondryColor,
              radius: 25.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl.toString(),
                  useOldImageOnUrlChange: true,
                  placeholder: (context, url) =>
                      CupertinoActivityIndicator(
                        radius: 15,
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            // onTap: () => showDialog(
            //     barrierDismissible: false,
            //     context: context,
            //     builder: (context) {
            //       return Info(widget.second, widget.sender, null);
            //     }),
          ),
        ],
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: documentSnapshot.data['image_url'] != ''
                  ? InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(
                          top: 2.0, bottom: 2.0, right: 15),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            Center(
                              child: CupertinoActivityIndicator(
                                radius: 10,
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .65,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .9,
                        imageUrl:
                        documentSnapshot.data['image_url'] ?? '',
                        fit: BoxFit.fitWidth,
                      ),
                      height: 150,
                      width: 150.0,
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      padding: EdgeInsets.all(5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                          documentSnapshot.data["time"] != null
                              ? DateFormat.yMMMd()
                              .add_jm()
                              .format(documentSnapshot.data["time"]
                              .toDate())
                              .toString()
                              : "",
                          style: TextStyle(
                            color: secondryColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          )),
                    )
                  ],
                ),
                onTap: () {
                  ///TODO: Create new page.
                  // Navigator.of(context).push(CupertinoPageRoute(
                  //   builder: (context) => LargeImage(
                  //     documentSnapshot.data['image_url'],
                  //   ),
                  // ));
                },
              )
                  : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.65,
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10),
                  decoration: BoxDecoration(
                      color: secondryColor.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                documentSnapshot.data['text'],
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                documentSnapshot.data["time"] != null
                                    ? DateFormat.MMMd()
                                    .add_jm()
                                    .format(documentSnapshot
                                    .data["time"]
                                    .toDate())
                                    .toString()
                                    : "",
                                style: TextStyle(
                                  color: secondryColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
    if (!(documentSnapshot.data() as Map)['isRead']) {
      chatReference!.doc(documentSnapshot.id).update({
        'isRead': true,
      });

      return _messagesIsRead(documentSnapshot);
    }
    return _messagesIsRead(documentSnapshot);
  }

  generateMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map<Widget>((doc) =>
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (doc.data as Map)['type'] == "Call"
              ? [
              Text((doc.data as Map)["time"] != null
                  ? "${(doc.data as Map)['text']} : " +
                  DateFormat.yMMMd()
                      .add_jm()
                      .format((doc.data as Map)["time"].toDate())
                      .toString() +
                  " by ${(doc.data as Map)['sender_id'] == widget.sender.id
                      ? "You"
                      : "${widget.second_name.toString()}"}"
                  : "")
              ]
                  : (doc.data as Map)['sender_id'] != widget.sender.id
              ? generateReceiverLayout(doc)
              : generateSenderLayout(doc),
        ),
    )).
    toList
    (
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff0e289f),
        title: Text(widget.second_name.toString()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: chatReference!
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(primaryColor),
                          strokeWidth: 2,
                        ),
                      );
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: generateMessages(snapshot),
                      ),
                    );
                  },
                ),
                Divider(height: 1.0),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(color: Theme
                      .of(context)
                      .cardColor),
                  child: isBlocked
                      ? Text("Sorry You can't send message!")
                      : _buildTextComposer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDefaultSendButton() {
    return IconButton(
      icon: Transform.rotate(
        angle: -pi / 9,
        child: Icon(
          Icons.send,
          size: 25,
        ),
      ),
      color: primaryColor,
      onPressed: _isWritting
          ? () => _sendText(_textController.text.trimRight())
          : null,
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: _isWritting ? primaryColor : secondryColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(
                      Icons.photo_camera,
                      color: primaryColor,
                    ),
                    onPressed: () async {
                      var image = await ImagePicker().getImage(
                          source: ImageSource.gallery);
                      int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      Reference storageReference = FirebaseStorage
                          .instance
                          .ref()
                          .child('chats/${widget.chatId}/img_' +
                          timestamp.toString() +
                          '.jpg');
                      UploadTask uploadTask = storageReference.putFile(
                          File(image!.path));
                      // await uploadTask.onComplete;
                      String fileUrl = await storageReference.getDownloadURL();
                      _sendImage(messageText: 'Photo', imageUrl: fileUrl);
                    }),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  maxLines: 15,
                  minLines: 1,
                  autofocus: false,
                  onChanged: (String messageText) {
                    setState(() {
                      _isWritting = messageText
                          .trim()
                          .length > 0;
                    });
                  },
                  decoration: new InputDecoration.collapsed(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(18)),
                      hintText: "Send a message..."),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _sendText(String text) async {
    _textController.clear();
    chatReference!.add({
      'type': 'Msg',
      'text': text,
      'sender_id': widget.sender.id,
      'receiver_id': widget.second_id.toString(),
      'isRead': false,
      'image_url': '',
      'time': FieldValue.serverTimestamp(),
    }).then((documentReference) {
      setState(() {
        _isWritting = false;
      });
    }).catchError((e) {});
  }

  void _sendImage({required String messageText, required String imageUrl}) {
    chatReference!.add({
      'type': 'Image',
      'text': messageText,
      'sender_id': widget.sender.id,
      'receiver_id': widget.second_id.toString(),
      'isRead': false,
      'image_url': imageUrl,
      'time': FieldValue.serverTimestamp(),
    });
  }

//   Future<void> onJoin(callType) async {
//     if (!isBlocked) {
//       // await for camera and mic permissions before pushing video page
//
//       await handleCameraAndMic(callType);
//       await chatReference!.add({
//         'type': 'Call',
//         'text': callType,
//         'sender_id': widget.sender.id,
//         'receiver_id': widget.second_id.toString(),
//         'isRead': false,
//         'image_url': "",
//         'time': FieldValue.serverTimestamp(),
//       });
//
//       // push video page with given channel name
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DialCall(
//             channelName: widget.chatId,
//             callType: callType,
//           ),
//         ),
//       );
//     } else {
//       CustomSnackbar.snackbar("Blocked !", _scaffoldKey);
//     }
//   }
// }

  Future<void> handleCameraAndMic(callType) async {
    ///TODO: Request permissions.
    // await PermissionHandler().requestPermissions(callType == "VideoCall"
    //     ? [PermissionGroup.camera, PermissionGroup.microphone]
    //     : [PermissionGroup.microphone]);
  }
}
