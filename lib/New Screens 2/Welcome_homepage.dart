import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cns/New Screens 2/Calenderx.dart';
import 'package:cns/New Screens 2/carouselnews.dart';
import 'package:cns/New%20Screens%202/Message_page.dart';
import 'package:cns/New%20Screens%202/notification_page.dart';
import 'package:cns/New%20Screens%202/pet_adoption.dart';
import 'package:cns/New%20Screens%202/pet_match_select.dart';
import 'package:cns/New%20Screens%202/profilen.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';

class NewScreenSecondHomePage extends StatefulWidget {
  @override
  _NewScreenSecondHomePageState createState() =>
      _NewScreenSecondHomePageState();
}

class _NewScreenSecondHomePageState extends State<NewScreenSecondHomePage>
    with AutomaticKeepAliveClientMixin {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  PageController? _pageController;
  MenuPositionController? _menuPositionController;
  bool userPageDragging = false;
  int position = 0;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: position);

    _pageController =
        PageController(initialPage: 0, viewportFraction: 1.0);
    _pageController!.addListener(handlePageChange);
    super.initState();
  }

  void handlePageChange() {
    _menuPositionController!.absolutePosition = _pageController!.page;
    position = _pageController!.page!.toInt();
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController!.findNearestTarget(_pageController!.page);
      position = _pageController!.page!.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdf8ff),
      bottomNavigationBar: BubbledNavigationBar(
        controller: _menuPositionController,
        defaultBubbleColor: Color(0xff1fa2ea),
        onTap: (index) {
          _pageController!.animateToPage(
            index,
            curve: Curves.easeInOutQuad,
            duration: Duration(milliseconds: 300),
          );
        },
        items: <BubbledNavigationBarItem>[
          BubbledNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Color(0xff01b4c9),
            ),
            activeIcon:
                Icon(CupertinoIcons.home, size: 30, color: Colors.white),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          BubbledNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              size: 30,
              color: Color(0xff01b4c9),
            ),
            activeIcon:
                Icon(Icons.calendar_today, size: 30, color: Colors.white),
            title: Text(
              'Calender',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          BubbledNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              size: 30,
              color: Color(0xff01b4c9),
            ),
            activeIcon:
                Icon(Icons.message_outlined, size: 30, color: Colors.white),
            title: Text(
              'Message',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          BubbledNavigationBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled,
              size: 30,
              color: Color(0xff01b4c9),
            ),
            activeIcon: Icon(CupertinoIcons.profile_circled,
                size: 30, color: Colors.white),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
      body: PageView(
        key: Key("A"),
        controller: _pageController,
        children: [
          HomePageBottomBar(),
          CalenderPage(),
          MessagePage(),
          ProfileScreen(),
        ],
        onPageChanged: (page) {
          _menuPositionController!.absolutePosition = _pageController!.page;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 60.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Consumer<MainProvider>(
      builder: (_, acc, __) {
        return Container(
          padding: EdgeInsets.only(top: statusBarHeight),
          height: statusBarHeight + barHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome " + acc.currentUser.name.toString(),
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                        TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff1fa2ea),Color(0xff1fa2ea)],
            ),
          ),
        );
      },
    );
  }
}

class HomePageBottomBar extends StatefulWidget {
  @override
  _HomePageBottomBarState createState() => _HomePageBottomBarState();
}

class _HomePageBottomBarState extends State<HomePageBottomBar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GradientAppBar("Welcome "),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      "Where would you like to go ?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 24,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetMatchSelect(),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: LinearGradient(
                            colors: [Color(0xff1fa2ea),Color(0xff1fa2ea)],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.white,
                                ),
                                child: Icon(Icons.pets_rounded),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Pet Match",
                                  style: GoogleFonts.abrilFatface(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetAdoption(),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: LinearGradient(
                            colors: [Color(0xff1fa2ea),Color(0xff1fa2ea)],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 16.0),
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.white,
                                ),
                                child: Icon(Icons.home_filled),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Pet Adoption",
                                  style: GoogleFonts.nunito(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20, // Pets loading code below commented
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Latest News",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  initialPage: 2,
                  autoPlay: true,
                ),
                items: imageSliders,
              )),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Technology",
          //         textAlign: TextAlign.start,
          //         style: GoogleFonts.nunito(
          //           fontSize: 24,
          //           color: Colors.black,
          //           fontStyle: FontStyle.normal,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     child: CarouselSlider(
          //   options: CarouselOptions(
          //     aspectRatio: 2.0,
          //     enlargeCenterPage: true,
          //     enableInfiniteScroll: true,
          //     initialPage: 2,
          //     autoPlay: true,
          //   ),
          //   items: imageSliders,
          // ))

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Manage your Pets Here",
          //         textAlign: TextAlign.start,
          //         style: GoogleFonts.nunito(
          //           fontSize: 24,
          //           color: Colors.black,
          //           fontStyle: FontStyle.normal,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 12,
          // ),
          // Consumer<MainProvider>(
          //   builder: (_, pets, __) {
          //     return pets.petsmodel == null
          //         ? SizedBox(
          //             height: 40,
          //             child: InkWell(
          //               onTap: () {
          //                 print("AddPet");
          //                 Navigator.push(context,
          //                     MaterialPageRoute(builder: (context) => AddPet()));
          //               },
          //               child: SizedBox(
          //                 height: 50,
          //                 child: ElevatedButton(
          //                   onPressed: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) => AddPet()));
          //                   },
          //                   child: Icon(
          //                     Icons.add_outlined,
          //                     color: Colors.black,
          //                     size: 30,
          //                   ),
          //                   style: ButtonStyle(
          //                     backgroundColor:
          //                         MaterialStateProperty.all<Color>(Colors.white),
          //                     foregroundColor:
          //                         MaterialStateProperty.all<Color>(Colors.white),
          //                     shape: MaterialStateProperty.all<
          //                         RoundedRectangleBorder>(
          //                       RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(90),
          //                           side: BorderSide(color: Colors.black)),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         : Container(
          //             height: 120,
          //             child: ListView.separated(
          //               separatorBuilder: (_, __) {
          //                 return SizedBox(
          //                   width: 15,
          //                 );
          //               },
          //               padding: EdgeInsets.all(10),
          //               itemCount: pets.petsmodel.length == 0
          //                   ? 1
          //                   : pets.petsmodel.length + 1,
          //               itemBuilder: (context, index) {
          //                 if (index == pets.petsmodel.length) {
          //                   return SizedBox(
          //                     height: 50,
          //                     child: InkWell(
          //                       onTap: () {
          //                         print("AddPet");
          //                         Navigator.push(
          //                             context,
          //                             MaterialPageRoute(
          //                                 builder: (context) => AddPet()));
          //                       },
          //                       child: SizedBox(
          //                         height: 50,
          //                         child: ElevatedButton(
          //                           onPressed: () {
          //                             Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                     builder: (context) => AddPet()));
          //                           },
          //                           child: Icon(
          //                             Icons.add_outlined,
          //                             color: Colors.black,
          //                             size: 40,
          //                           ),
          //                           style: ButtonStyle(
          //                             backgroundColor:
          //                                 MaterialStateProperty.all<Color>(
          //                                     Colors.white),
          //                             foregroundColor:
          //                                 MaterialStateProperty.all<Color>(
          //                                     Colors.white),
          //                             shape: MaterialStateProperty.all<
          //                                 RoundedRectangleBorder>(
          //                               RoundedRectangleBorder(
          //                                   borderRadius:
          //                                       BorderRadius.circular(50),
          //                                   side:
          //                                       BorderSide(color: Colors.black)),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   );
          //                 }
          //                 return Container(
          //                   child: InkWell(
          //                     onTap: () async {
          //                       await Provider.of<MainProvider>(context,
          //                               listen: false)
          //                           .petDetailId(
          //                               pets.petsmodel[index].id.toString());
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                           builder: (context) => EditProfile(
          //                             e: pets.petsmodel[index],
          //                             documentId:
          //                                 pets.petsmodel[index].id.toString(),
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                     child: CircleAvatar(
          //                       radius: 50,
          //                       backgroundImage: NetworkImage(
          //                         pets.petsmodel[index].imageUrl[0].toString(),
          //                       ),
          //                       backgroundColor: Color(0xffa8bcfb).withOpacity(0.4),
          //                     ),
          //                   ),
          //                 );
          //               },
          //               scrollDirection: Axis.horizontal,
          //             ),
          //           );
          //   },
          // ),
          // SizedBox(
          //   height: 4,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Add Yor Pet For Adoption",
          //         textAlign: TextAlign.start,
          //         style: GoogleFonts.nunito(
          //           fontSize: 24,
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           fontStyle: FontStyle.normal,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 12,
          // ),
          // Consumer<MainProvider>(
          //   builder: (_, petsadoption, __) {
          //     return petsadoption.pet_adoption_model == null
          //         ? SizedBox(
          //           height: 50,
          //             child: InkWell(
          //             onTap: () {
          //               print("Pet Adoption");
          //               Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => AddPetAdoption()));
          //         },
          //               child: SizedBox(
          //           height: 30,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => AddPet()));
          //             },
          //             child: Icon(
          //               Icons.add_outlined,
          //               color: Colors.black,
          //               size: 40,
          //             ),
          //             style: ButtonStyle(
          //               backgroundColor:
          //               MaterialStateProperty.all<Color>(Colors.white),
          //               foregroundColor:
          //               MaterialStateProperty.all<Color>(Colors.white),
          //               shape: MaterialStateProperty.all<
          //                   RoundedRectangleBorder>(
          //                 RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(50),
          //                     side: BorderSide(color: Colors.black)),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //         : Container(
          //       height: 120,
          //       child: ListView.separated(
          //         separatorBuilder: (_, __) {
          //           return SizedBox(
          //             width: 15,
          //           );
          //         },
          //         padding: EdgeInsets.all(10),
          //         itemCount: petsadoption.pet_adoption_model.length == 0
          //             ? 1
          //             : petsadoption.pet_adoption_model.length + 1,
          //         itemBuilder: (context, index) {
          //           if (index == petsadoption.pet_adoption_model.length) {
          //             return SizedBox(
          //               height: 50,
          //               child: InkWell(
          //                 onTap: () {
          //                   print("AddPet Pet Adoption");
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => AddPetAdoption()));
          //                 },
          //                 child: SizedBox(
          //                   height: 50,
          //                   child: ElevatedButton(
          //                     onPressed: () {
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => AddPetAdoption()));
          //                       },
          //                     child: Icon(
          //                       Icons.add_outlined,
          //                       color: Colors.black,
          //                       size: 40,
          //                     ),
          //                     style: ButtonStyle(
          //                       backgroundColor:
          //                       MaterialStateProperty.all<Color>(
          //                           Colors.white),
          //                       foregroundColor:
          //                       MaterialStateProperty.all<Color>(
          //                           Colors.white),
          //                       shape: MaterialStateProperty.all<
          //                           RoundedRectangleBorder>(
          //                         RoundedRectangleBorder(
          //                             borderRadius:
          //                             BorderRadius.circular(50),
          //                             side:
          //                             BorderSide(color: Colors.black)),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             );
          //           }
          //           return Container(
          //             child: InkWell(
          //               onTap: () async {
          //                 await Provider.of<MainProvider>(context,
          //                     listen: false)
          //                     .Petadoptiondetail(
          //                     petsadoption.pet_adoption_model[index].id.toString());
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => AdoptionEdit(
          //                       e: petsadoption.pet_adoption_model[index],
          //                       documentId:
          //                       petsadoption.pet_adoption_model[index].id.toString(),
          //                     ),
          //                   ),
          //                 );
          //               },
          //               child: CircleAvatar(
          //                 radius: 50,
          //                 backgroundImage: NetworkImage(
          //                   petsadoption.pet_adoption_model[index].imageUrl[0].toString(),
          //                 ),
          //                 backgroundColor: Color(0xffa8bcfb).withOpacity(0.4),
          //               ),
          //             ),
          //           );
          //         },
          //         scrollDirection: Axis.horizontal,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}
