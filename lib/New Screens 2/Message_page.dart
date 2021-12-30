import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/chat.dart';
import 'package:cns/New%20Screens%202/pet_adoption.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:cns/util/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;
  List<Widget> list = [
    Tab(icon: Icon(Icons.pets_sharp,
    color: Colors.white,)),
    Tab(icon: Icon(Icons.home_filled,
    color: Colors.white,)),
  ];

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      // print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Message",style: TextStyle(
            color: Colors.white
          ),),
          backgroundColor: Color(0xff01b4c9),
          bottom: TabBar(
            controller: _controller,
            tabs: list,
          ),

        ),
        body: TabBarView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // GradientAppBar("Message"),

                      Expanded(
                        child: Consumer<MainProvider>(
                          builder: (_, acc, __) {
                            return RecentChats(acc.currentUser, acc);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // GradientAppBar("Message"),

                      Expanded(
                        child: Consumer<MainProvider>(
                          builder: (_, acc, __) {
                            return RecentChats(acc.currentUser, acc);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      //     color: Colors.white,
      //   ),
      //   child: ClipRRect(
      //     // borderRadius: BorderRadius.only(
      //     //     topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      //     child: GestureDetector(
      //       onTap: () => FocusScope.of(context).unfocus(),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           GradientAppBar("Message"),
      //
      //           Expanded(
      //             child: Consumer<MainProvider>(
      //               builder: (_, acc, __) {
      //                 return RecentChats(acc.currentUser);
      //               },
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

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
            SizedBox(
              width: 15,
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
            Color(0xff01b4c9)
          ],
        ),
      ),
    );
  }
}

class RecentChats extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final NewUser currentUser;
  final MainProvider account;


  RecentChats(this.currentUser, this.account);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child:  ListView.builder(
        itemCount: (account.petsmodelByGender.length == null) ? 0 : account.petsmodelByGender.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(
                  chatId: chatId(currentUser.id, account.petsmodelByGender[index].id),
                  sender: currentUser,
                  second_id: account.petsmodelByGender[index].id,
                  second_name: account.petsmodelByGender[index].petName.toString(),
                  imageUrl: account.petsmodelByGender[index].imageUrl[0],
                ),
              ),
            ),
            child: StreamBuilder(
              stream: db
                  .collection("chats")
                  .doc(
                chatId(currentUser.id,
                    account.petsmodelByGender[index].id,
                ),
              )
                  .collection('messages')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (!snapshot.hasData)
                  return Container(
                    child: CupertinoActivityIndicator(),
                  );
                else if (snapshot.data.documents.length == 0) {
                  return Container(
                  );
                }
                // index.lastmsg = snapshot.data.documents[0]['time'];
                return Container(
                  margin:
                  EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0,left: 10.0),

                  decoration: BoxDecoration(
                    color: snapshot.data.documents[0]['sender_id'] !=
                        currentUser.id &&
                        !snapshot.data.documents[0]['isRead']
                        ? Colors.white.withOpacity(.1)
                        : Colors.white.withOpacity(.2),

                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: secondryColor,
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              "${account.petsmodelByGender[index].imageUrl[0].toString()}"),
                        ),
                        title: Text(
                          account.petsmodelByGender[index].petName
                              .toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          snapshot.data.documents[0]['image_url']
                              .toString()
                              .length >
                              0
                              ? "Photo"
                              : snapshot.data.documents[0]['text'],
                          style: TextStyle(
                            color: Color(0xff01b4c9),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              snapshot.data.documents[0]["time"] != null
                                  ? DateFormat.MMMd()
                                  .add_jm()
                                  .format(snapshot
                                  .data.documents[0]["time"]
                                  .toDate())
                                  .toString()
                                  : "",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            snapshot.data.documents[0]['sender_id'] !=
                                currentUser.id &&
                                !snapshot.data.documents[0]['isRead']
                                ? Container(
                              width: 40.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                BorderRadius.circular(30.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                                : Text(""),
                            snapshot.data.documents[0]['sender_id'] ==
                                currentUser.id
                                ? !snapshot.data.documents[0]['isRead']
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
                                : Text("")
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


