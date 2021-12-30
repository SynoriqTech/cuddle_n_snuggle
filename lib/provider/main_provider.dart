import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cns/models/custom_web_view.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/models/petadoption.dart';
import 'package:cns/models/pets.dart';
import 'package:url_launcher/url_launcher.dart';

class MainProvider extends ChangeNotifier {
  late NewUser currentUser;

  List<PetsModel> petsmodel = [];
  List<PetsModel> pet_match = [];

  List<PetsModel> petsmodelByGender = [];

  List<PetsAdoption> pet_adoption_model = [];
  List<PetsAdoption> pet_adopt = [];
  ValueNotifier<List<DocumentSnapshot>> petNotifier = ValueNotifier<List<DocumentSnapshot>>([]);
  dynamic petCategory;
  dynamic petSubCategory;
  Stream<DocumentSnapshot>? petDetail;

  // <List<DocumentSnapshot>> pets
  List<DocumentSnapshot> pets = <DocumentSnapshot>[];
  List<DocumentSnapshot> petsadoption = <DocumentSnapshot>[];

  static const your_client_id = '859647244877727';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const your_redirect_url = 'https://cnsi-b4f1c.firebaseapp.com/__/auth/handler';

  Future<dynamic> petmatch(String cate, String sex, String subcat) async {
    await FirebaseFirestore.instance
        .collection('Pets')
        .where('category', isEqualTo: cate)
        .where('subcategory', isEqualTo: subcat)
        .where('sex', isEqualTo: sex.contains("fe") ? "Male" : "Female")
        .get()
        .then((data) {
      List<PetsModel> orders = <PetsModel>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          print(data.docs[i]["subcategory"]);
          orders.add(PetsModel.fromDocument(data.docs[i], data.docs[i].data()));
        }
        pet_match = orders;
        notifyListeners();
        // print(pet_match[0].category.toString());
      } else {
        print("No data for pet match");
      }
    });
  }

  Future<dynamic> petmatchByGender(String cate, String sex, String subcat) async {
    await FirebaseFirestore.instance
        .collection('Pets')
        .where('category', isEqualTo: cate)
        .where('subcategory', isEqualTo: subcat)
        .where('sex', isEqualTo: sex.contains("fe") ? "Male" : "Female")
        .get()
        .then((data) {
      List<PetsModel> orders = <PetsModel>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          orders.add(PetsModel.fromDocument(data.docs[i], data.docs[i].data()));

          orders.removeWhere((element) => element.userId == currentUser.id);
          petsmodelByGender = orders;
          notifyListeners();
        }
      } else {
        print("No Data Found");
      }
    });
  }

  Future<dynamic> petadoption(String cate, String sex, String subcat) async {
    await FirebaseFirestore.instance.collection('PetAdoption').get().then((data) {
      List<PetsAdoption> orders = <PetsAdoption>[];
      int totalCount = data.docs.length;
      print("____________________________");
      print(totalCount);
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          orders.add(PetsAdoption.fromDocument(data.docs[i], data.docs[i].data()));
          orders.removeWhere((element) => element.userId == currentUser.id);
          pet_adoption_model = orders;
          notifyListeners();
        }
      } else {
        print("No Pet Adoption");
      }
    });
  }

  Future<dynamic> play_date() async {
    await FirebaseFirestore.instance.collection('Pets').get().then(
      (data) {
        List<PetsModel> orders = <PetsModel>[];
        int totalCount = data.docs.length;
        if (data.docs.isNotEmpty) {
          print("========== Length ==========");
          print(data.docs.length);
          for (int i = 0; i < totalCount; i++) {
            print("Name------------");
            print(data.docs[i].data()["name"]);
            orders.add(PetsModel.fromDocument(data.docs[i], data.docs[i].data()));
            orders.removeWhere((element) => element.userId == currentUser.id);
            pet_match = orders;
            notifyListeners();
          }
        } else {
          return "Error";
        }
      },
    );
  }

  Future<dynamic> handleGoogleSign(BuildContext context, String isIndiviual) async {
    User _user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    _user = authResult.user!;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = _auth.currentUser!;
    assert(_user.uid == currentUser.uid);
    print("User Name NEW INDividual: ${_user.displayName}");
    print("User Email NEW Individual: ${_user.email}");
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: authResult.user!.uid)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.length <= 0) {
          await setDataUser(authResult.user!, isIndiviual, authResult.user!.displayName!);
        }
        await loadUserDetails();
      });
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> handleGoogleSignNGO(
    BuildContext context,
    String isNGO,
  ) async {
    User _user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    _user = authResult.user!;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = await _auth.currentUser!;
    assert(_user.uid == currentUser.uid);
    print("User Name NGO: ${_user.displayName}");
    print("User Email NGO:  ${_user.email}");
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: authResult.user!.uid)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.length <= 0) {
          await setDataUser(authResult.user!, isNGO, authResult.user!.displayName!);
        }
        await loadUserDetails();
      });
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> loadUserDetails() async {
    // CollectionReference docRef = Firestore.instance.collection('Users');
    User user = FirebaseAuth.instance.currentUser!;
    print("User---------------------");
    print(user.uid);
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) async {
      print("Current user");
      currentUser = NewUser.fromDocument(snapshot.docs[0]);
      notifyListeners();
      print("Getting Pet match pets");
      getPets();
      print("Getting pets adoption");
      getAdoptionPets();
      print("----------- Name --------------");
      print(currentUser.name.toString());
      return currentUser;
    });
  }

  Future<dynamic> decideSplash() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? authResult = _auth.currentUser;
    if (authResult == null) {
      print("NotVerified");
    } else {
      await loadUserDetails();
      await getPets();
      await getAdoptionPets();
    }
  }

  // Future<dynamic> addPetsadoption(
  //     String name,
  //     String dob,
  //     String category,
  //     File _image,
  //     String subcategory,
  //     String bio,
  //     bool vaccinated,
  //     bool kssi) async {
  //   try {
  //     String _uploadedFileURL = "";
  //     StorageReference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child("PetAdoption/${_image.hashCode}.jpg");
  //     StorageUploadTask uploadTask = storageReference.putFile(_image);
  //     await uploadTask.onComplete;
  //     await storageReference.getDownloadURL().then((fileURL) {
  //       _uploadedFileURL = fileURL;
  //     });
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     _auth.currentUser().then((FirebaseUser user) => {
  //           Firestore.instance
  //               .collection("Users/${user.uid}/PetAdoption")
  //               .document()
  //               .setData(
  //             {
  //               "name": name.toString(),
  //               "petdob": dob.toString(),
  //               "category": category.toString(),
  //               "image": FieldValue.arrayUnion([
  //                 _uploadedFileURL,
  //               ]),
  //               "subcategory": subcategory.toString(),
  //               "bio": bio.toString(),
  //               "vaccinated": vaccinated.toString(),
  //               "kssi_certified": kssi.toString()
  //             },
  //           ),
  //         });
  //     getAdoptionPets();
  //     return "Success";
  //   } catch (e) {
  //     print("------- Error ---------");
  //     print(e);
  //     print("------- Error ---------");
  //   }
  // }

  Future<dynamic> addPets(String name, String dob, String category, File _image, String subcategory, String bio,
      bool vaccinated, bool kssi) async {
    try {
      String _uploadedFileURL = "";
      Reference storageReference = FirebaseStorage.instance.ref().child("Pets/${_image.hashCode}.jpg");
      UploadTask uploadTask = storageReference.putFile(_image);
      await storageReference.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
      });
      final FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseFirestore.instance.collection("Users/${_auth.currentUser!.uid}/Pets").doc().set(
        {
          "name": name.toString(),
          "petdob": dob.toString(),
          "category": category.toString(),
          "image": FieldValue.arrayUnion([
            _uploadedFileURL,
          ]),
          "subcategory": subcategory.toString(),
          "bio": bio.toString(),
          "vaccinated": vaccinated.toString(),
          "kssi_certified": kssi.toString()
        },
      );
      getPets();
      return "Success";
    } catch (e) {
      print("------- Error ---------");
      print(e);
      print("------- Error ---------");
    }
  }

  Future<dynamic> addPetsPublic(
    String name,
    String dob,
    String category,
    File _image,
    String subcategory,
    String bio,
    bool vaccinated,
    bool kssi,
    String sex,
  ) async {
    try {
      String _uploadedFileURL = "";
      Reference storageReference = FirebaseStorage.instance.ref().child("Pets/${_image.hashCode}.jpg");
      UploadTask uploadTask = storageReference.putFile(_image);
      // await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
      });
      FirebaseFirestore.instance.collection("Pets").doc().set(
        {
          "name": name.toString(),
          "petdob": dob.toString(),
          "category": category.toString(),
          "image": FieldValue.arrayUnion([
            _uploadedFileURL,
          ]),
          "subcategory": subcategory.toString(),
          "bio": bio.toString(),
          "vaccinated": vaccinated.toString(),
          "kssi_certified": kssi.toString(),
          "userId": currentUser.id.toString(),
          "userName": currentUser.name.toString(),
          "sex": sex.toString()
        },
      );
      getPets();
      return "Success";
    } catch (e) {
      print("------- Error ---------");
      print(e);
      print("------- Error ---------");
    }
  }

  Future<dynamic> addPetsAdoption(
    String name,
    String dob,
    String category,
    File _image,
    String subcategory,
    String bio,
    bool vaccinated,
    bool kssi,
    String sex,
  ) async {
    try {
      String _uploadedFileURL = "";
      Reference storageReference = FirebaseStorage.instance.ref().child("PetAdoption/${_image.hashCode}.jpg");
      UploadTask uploadTask = storageReference.putFile(_image);
      // await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
      });
      FirebaseFirestore.instance.collection("PetAdoption").doc().set(
        {
          "name": name.toString(),
          "petdob": dob.toString(),
          "category": category.toString(),
          "image": FieldValue.arrayUnion([
            _uploadedFileURL,
          ]),
          "subcategory": subcategory.toString(),
          "bio": bio.toString(),
          "vaccinated": vaccinated.toString(),
          "kssi_certified": kssi.toString(),
          "userId": currentUser.id.toString(),
          "userName": currentUser.name.toString(),
          "sex": sex.toString()
        },
      );
      getAdoptionPets();
      return "Success";
    } catch (e) {
      print("------- Error ---------");
      print(e);
      print("------- Error ---------");
    }
  }

  Future<dynamic> petDetailId(String documentId) async {
    petDetail =
        FirebaseFirestore.instance.collection('Users/${_auth.currentUser!.uid}/Pets').doc(documentId).snapshots();
    notifyListeners();
  }

  Future<dynamic> Petadoptiondetail(String documentId) async {
    petDetail = FirebaseFirestore.instance
        .collection('Users/${_auth.currentUser!.uid}/PetAdoption')
        .doc(documentId)
        .snapshots();
    notifyListeners();
  }

  Future<dynamic> update_pet_details(String documentId) async {
    await FirebaseFirestore.instance.doc("Users/${currentUser.id}/Pets/$documentId").update({});
  }

  Future<dynamic> uploadFile(File _image) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('chats/(_image.path)}}');
    UploadTask uploadTask = storageReference.putFile(_image);
    // await uploadTask.onComplete;
    print('File Uploaded');
  }

  Future<dynamic> getPets() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User user = _auth.currentUser!;
      print(user.uid);
      FirebaseFirestore.instance.collection('Pets').where('userId', isEqualTo: user.uid).get().then((data) {
        List<PetsModel> orders = <PetsModel>[];
        List<String> petcat = [];
        List<String> petsubcat = [];

        int totalCount = data.docs.length;

        if (totalCount == 0) {
          petsmodel = [];
          petcat = [];
          petsubcat = [];
          notifyListeners();
        }
        if (data.docs.isNotEmpty) {
          print(data.docs[0].data());
          for (int i = 0; i < totalCount; i++) {
            orders.add(PetsModel.fromDocument(data.docs[i], data.docs[i].data()));
            petcat.add(data.docs[i]["category"]);
            petsubcat.add(data.docs[i]["subcategory"]);
          }
          petCategory = petcat;
          petSubCategory = petsubcat;
          petsmodel = orders;
          notifyListeners();
          for (int i = 0; i < petcat.length; i++) {
            petmatch(
              petsmodel[i].category.toString(),
              petsmodel[i].sex.toString() == "Male" ? "Female" : "Male",
              petsmodel[i].subcategory.toString(),
            );
          }
        } else {
          print("Error");
        }
      });
    } catch (e) {
      print("------- Error for pet adoption ---------");
      print(e);
      print("------- Error ---------");
    }
  }

  Future<dynamic> getAdoptionPets() async {
    print("Geting pets REady adoption--------------------");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User user = _auth.currentUser!;
    print(user.uid);
    FirebaseFirestore.instance.collection('PetAdoption').where('userId', isEqualTo: user.uid).get().then((data) {
      List<PetsAdoption> orders = <PetsAdoption>[];
      List<String> petcat = [];
      List<String> petsubcat = [];

      int totalCount = data.docs.length;
      print("----- Total Count Pet Adoption -----");
      print(totalCount);
      print("----- Total Count -----");
      if (totalCount == 0) {
        pet_adopt = [];
        petcat = [];
        petsubcat = [];
        notifyListeners();
      }
      if (data.docs.isNotEmpty) {
        print(data.docs[0].data());
        for (int i = 0; i < totalCount; i++) {
          orders.add(PetsAdoption.fromDocument(data.docs[i], data.docs[i].data()));
          petcat.add(data.docs[i]["category"]);
          petsubcat.add(data.docs[i]["subcategory"]);
        }
        petCategory = petcat;
        petSubCategory = petsubcat;
        pet_adoption_model = orders; // not sure
        notifyListeners();
        for (int i = 0; i < petcat.length; i++) {
          petadoption(
            pet_adopt[i].category.toString(),
            pet_adopt[i].sex.toString() == "Male" ? "Female" : "Male",
            pet_adopt[i].subcategory.toString(),
          );
        }
      } else {
        print("Error");
      }
    });
  }

  // Future<dynamic> pet_adoption() async {
  //
  //     await Firestore.instance
  //         .collection('PetAdoption')
  //         .getDocuments()
  //         .then((data) {
  //       List<PetsAdoption> orders = List<PetsAdoption>();
  //       int totalCount = data.documents.length;
  //       if (totalCount == 0) {
  //         pet_adoption_model = [];
  //         notifyListeners();
  //       }
  //       if (data.documents.isNotEmpty) {
  //         print(data.documents[0].documentID);
  //         for (int i = 0; i < totalCount; i++) {
  //           orders.add(PetsAdoption.fromDocument(
  //               data.documents[i], data.documents[i].documentID));
  //         }
  //         pet_adoption_model = orders;
  //         notifyListeners();
  //       } else {
  //         print("Error");
  //       }
  //     });
  // }

  Future<dynamic> handleFacebookLogin(context) async {
    User user;
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomWebView(
          selectedUrl:
              'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
        ),
        maintainState: true,
      ),
    );
    try {
      final facebookAuthCred = FacebookAuthProvider.credential(result);
      user = (await FirebaseAuth.instance.signInWithCredential(facebookAuthCred)).user!;
      print('user $user');
      return "Success";
    } catch (e) {
      print('Error $e');
      return e;
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future<dynamic> signinusingemailandpassword(
  //     String email, String password) async {
  //   try {
  //     User _user;
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     UserCredential authResult = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     _user = authResult.user;
  //     assert(_user != null);
  //     assert(await _user.getIdToken() != null);
  //     final User currentUser = await _auth.currentUser!;
  //     assert(_user.uid == currentUser.uid);
  //     return "Success";
  //   } catch (e) {
  //     print(e);
  //     return e.toString();
  //   }
  // }

  // Future<dynamic> emailPasswordLogin(String email, String password, String name,
  //     context, String isIndiviual) async {
  //   try {
  //     User _user;
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     UserResult authResult = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     _user = authResult.user;
  //     assert(_user != null);
  //     assert(await _user.getIdToken() != null);
  //     FirebaseFirestore.instance
  //         .collection('Users')
  //         .where('userId', isEqualTo: authResult.user.uid)
  //         .get()
  //         .then((QuerySnapshot snapshot) async {
  //       if (snapshot.documents.length <= 0) {
  //         await setDataUser(authResult.user, isIndiviual, name);
  //       }
  //     });
  //     User currentUser =  _auth.currentUser!;
  //     print("-------------------------------");
  //     print(currentUser.email);
  //     if (currentUser != null) {
  //       FirebaseFirestore.instance
  //           .collection('Users')
  //           .where('userId', isEqualTo: authResult.user.uid)
  //           .get()
  //           .then((QuerySnapshot snapshot) async {
  //         if (snapshot.docs.length <= 0) {
  //           await setDataUser(authResult.user, isIndiviual, name);
  //         }
  //       });
  //       return "New User";
  //     } else {
  //       return "Old User";
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  Future setDataUser(User user, String isIndiviual, String name) async {
    print("------- Set data User Name ----------");
    print(name);
    await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
        {
          'userId': user.uid,
          'isIndiviual': isIndiviual,
          'userName': name,
          'phoneNumber': user.phoneNumber,
          'timestamp': FieldValue.serverTimestamp(),
          'Pets': FieldValue.arrayUnion([]),
          'Pictures': FieldValue.arrayUnion([
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s"
          ])
        },
        SetOptions(
          merge: true,
        ));
  }
}
