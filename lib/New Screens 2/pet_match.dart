import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'pet_match_select.dart';
import 'package:cns/New Screens 2/Welcome_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cns/New%20Screens%202/Message_page.dart';
import 'package:cns/models/new_user_model.dart';

List userRemoved = [];

class PetMatchScreen extends StatefulWidget {
  final String category;
  final String subcategory;
  final String gender;

  const PetMatchScreen({ Key? key, required this.category, required this.gender, required this.subcategory})
      : super(key: key);

  @override
  _PetMatchScreenState createState() => _PetMatchScreenState();
}

class _PetMatchScreenState extends State<PetMatchScreen> {
  GlobalKey<SwipeStackState> swipeKey = GlobalKey<SwipeStackState>();

  CardController? controller;
  CollectionReference docRef = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  List matches = [];
  List oldMatches = [];
  List rejects = [];
  bool isLoading = true;

  @override
  void initState() {
    controller = CardController();
    fetchMatches();
    super.initState();
  }

  void fetchMatches() async {
    //Gets current logged in user
    User currentUser = _firebaseAuth.currentUser!;

    DocumentReference ref = FirebaseFirestore.instance
        .collection('matches')
        .doc(currentUser.uid.toString());

    DocumentSnapshot temp = await ref.get();
    Map? data = temp.data() as Map;
    print("___");
    //print(temp.data.keys.toList());

    matches = data == null ? [] : data.keys.toList();
    oldMatches = data == null
        ? []
        : data.entries
            .where((element) => element.value)
            .map((e) => e.key)
            .toList();
    print(["OLD MATCHES:", oldMatches]);
    temp = await FirebaseFirestore.instance
        .collection('rejects')
        .doc(currentUser.uid.toString())
        .get();
    //Check if match has a value of true. If yes, then its a old match.
    data = temp.data() as Map;

    rejects = data == null ? [] : data.keys.toList();
    setState(() {
      isLoading = false;
    });
  }

  void updateMatchList(
    NewUser currentUser,
    matchUser,
    bool isMatch,
  ) async {
    DocumentReference matches = FirebaseFirestore.instance
        .collection('matches')
        .doc(matchUser.id.toString());

    if (isMatch) {
      FirebaseFirestore.instance
          .collection("chats")
          .doc(chatId(currentUser.id, matchUser.id))
          .collection('messages')
          .add({
        "sender_id": matchUser.id,
        "receiver_id": currentUser.id,
        "isRead": false,
        'image_url': matchUser.imageUrl[0],
        "time": new DateTime.now(),
        "message": "Its a match! Say Hi Now!",
        "type": "Msg",
      });
      matches.update({currentUser.id.toString(): isMatch});
      FirebaseFirestore.instance
          .collection('matches')
          .doc(currentUser.id.toString())
          .update({matchUser.id: isMatch});
    } else
      matches.set({currentUser.id.toString(): isMatch}, SetOptions(merge: true));
  }

  updateRejectList(
    NewUser currentUser,
    String matchId,
  ) async {
    print("Updated reject with: ");
    print([currentUser, matchId]);
    DocumentReference matches = FirebaseFirestore.instance
        .collection('rejects')
        .doc(currentUser.id.toString());
    matches.set({matchId: false}, SetOptions(merge: true));
  }

  bool isPlayDate = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ITS A MATCH!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Looks like you Match!.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Go To Messages.'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MessagePage(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PetMatchSelect(),
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "Pet Match",
          style: Theme.of(context).textTheme.bodyText1!.merge(
                TextStyle(
                  fontSize: 25,
                ),
              ),
        ),
      ),
      body: Consumer<MainProvider>(
        builder: (_, pets, __) {
          pets.petmatchByGender(
              widget.category, widget.gender, widget.subcategory);
          List petsList = (isPlayDate
                  ? pets.petsmodel
                      .where((element) => element.id != pets.currentUser.id)
                  : pets.petsmodelByGender)

              .where((element) => !rejects.contains(element.id))
              // .where((element) => !oldMatches.contains(element.id))
              .toList();
          bool noMorePets = petsList.isEmpty;
          return Center(
            child: isLoading
                ? Container(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: MediaQuery.of(context).size.width *
                        0.9, //Need to be same as max child height
                    child: noMorePets
                        ? AnimatedOpacity(
                            key: UniqueKey(),
                            opacity: noMorePets ? 1 : 0,
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .78,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 40,
                                    ),
                                  ),
                                  Text(
                                    "There's no one new around you.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.none,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          )
                        : TinderSwapCard(
                            swipeUp: false,
                            swipeDown: false,
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: petsList.length,
                            stackNum: 3,
                            swipeEdge: 4.0,
                            animDuration: 300,
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: MediaQuery.of(context).size.width * 0.9,
                            minWidth: MediaQuery.of(context).size.width * 0.78,
                            minHeight: MediaQuery.of(context).size.width * 0.78,
                            cardBuilder: (context, index) => Card(
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${petsList[index].imageUrl[0].toString()}',
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Center(
                                        child: CupertinoActivityIndicator(
                                          radius: 15,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      height: 365,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RichText(
                                            softWrap: true,
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      "${petsList[index].petName}",
                                                  style: GoogleFonts.nunito(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "  ${petsList[index].category + " - " + petsList[index].subcategory}",
                                                  style: GoogleFonts.nunito(
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("${petsList[index].about}",
                                                  style: GoogleFonts.nunito(
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            cardController: controller,
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              if (align.x < 0) {
                              } else if (align.x > 0) {}
                            },
                            swipeCompleteCallback: (
                              CardSwipeOrientation orientation,
                              int index,
                            ) {
                              if (orientation == CardSwipeOrientation.LEFT) {
                                updateRejectList(
                                  pets.currentUser,
                                  petsList[index].id,
                                );
                              } else if (orientation ==
                                  CardSwipeOrientation.RIGHT) {
                                updateMatchList(
                                    pets.currentUser,
                                    petsList[index],
                                    matches.contains(petsList[index].id));

                                if (matches.contains(petsList[index].id)) {
                                  _showMyDialog();
                                }
                              }
                              if (index == (petsList.length - 1)) {
                                setState(() {
                                  noMorePets = true;
                                });
                              }
                            },
                          ),
                  ),
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: UniqueKey(),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.clear,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () {
                controller!.triggerLeft();
              },
            ),
            FloatingActionButton(
              heroTag: UniqueKey(),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.pets_rounded,
                color: Colors.lightBlueAccent,
                size: 30,

              ),
              onPressed: () {
                // _getMatches();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => MessagePage()));
                setState(() {
                  isPlayDate = !isPlayDate;
                });
              },
            ),
            FloatingActionButton(
              heroTag: UniqueKey(),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check,
                color: Colors.green,
                size: 30,
              ),
              onPressed: () {
                controller!.triggerRight();
              },
            ),
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
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetMatchSelect(),
                  ),
                );
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

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

var groupChatId;
chatId(currentUser, sender) {
  if (currentUser.hashCode <= sender.hashCode) {
    return groupChatId = '$currentUser-$sender';
  } else {
    return groupChatId = '$sender-$currentUser';
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
