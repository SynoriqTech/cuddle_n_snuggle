import 'package:flutter/material.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/New%20Screens%202/petsadoptionadd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/models/pets.dart';
import 'package:cns/New Screens 2/add_pets.dart';
import "package:provider/src/consumer.dart";

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff01b4c9),
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        elevation: 0,
      ),
      body: loader
          ? Center(child: CircularProgressIndicator())
          : Consumer<MainProvider>(
              builder: (context, info, _) => SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                      ),
                      title: Text(
                        currentUser!.displayName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      subtitle: Text(
                        currentUser!.email.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        "All Pet Match Pets",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 28,
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPet())),
                      ),
                    ),
                    ...info.petsmodel
                        .map(
                          (pet) => ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              pet.petName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Age: ${pet.age}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Sex: ${pet.sex}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            leading: Icon(
                              Icons.pets,
                              size: 45,
                              color: Colors.black,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.edit,
                                // size: 45,
                              ),
                              // color: Colors.black,
                              onPressed: () => null,
                            ),
                          ),
                        )
                        .toList(),

                    ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        "All Your Pet Adoption Pets",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 28,
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPetAdoption())),
                      ),
                    ),
                    ...info.pet_adoption_model
                        .map(
                          (pet) => ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          pet.petName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Age: ${pet.age}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Sex: ${pet.sex}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        leading: Icon(
                          Icons.pets,
                          size: 45,
                          color: Colors.black,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
                            // size: 45,
                          ),
                          // color: Colors.black,
                          onPressed: () => null,
                        ),
                      ),
                    )
                        .toList(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          child: Text("Settings"),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      height: 40,
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Change Radius",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Update Phone Number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.phone_callback,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.ios_share,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Share C&S",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("FAQs"),
                      ),
                      height: 40,
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Follow Us On Social Media",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Contact US",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.privacy_tip,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Terms and Condition",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  NewUser? user;

  void getdata() async {
    setState(() {
      loader = true;
    });
    currentUser = await firebaseAuth.currentUser!;
    FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: currentUser!.uid)
        .get()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.docs.length <= 0) {
        setState(() {
          user = NewUser.fromDocument(snapshot.docs[0]);
        });
      }
    });

    setState(() {
      loader = false;
    });
  }

  void getpets() async {
    setState(() {
      loader = true;
    });
    currentUser = await firebaseAuth.currentUser!;
    FirebaseFirestore.instance
        .collection('Pets')
        .where('userId', isEqualTo: user!.id)
        .get()
        .then((QuerySnapshot snapshot) async {
      List<PetsModel> orders = <PetsModel>[];
      List<String> petcat = [];
      List<String> petsubcat = [];
      int totalCount = snapshot.docs.length;
      if (snapshot.docs.isNotEmpty) {
        print(snapshot.docs[0].data());

        for (int i = 0; i < totalCount; i++) {
          orders.add(PetsModel.fromDocument(
              snapshot.docs[i], snapshot.docs[i].data()));
          petcat.add(snapshot.docs[i]["category"]);
          petsubcat.add(snapshot.docs[i]["subcategory"]);
        }
      }
    });
  }
}


