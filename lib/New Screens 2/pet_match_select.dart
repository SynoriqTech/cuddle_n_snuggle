import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cns/New Screens 2/pet_match.dart';
import 'package:cns/New%20Screens%202/add_pets.dart';
import 'package:cns/New%20Screens%202/pet_match.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cns/New Screens 2/pet_match_updated.dart';

class PetMatchSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Select the pet that you want to pet match for",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunito(
                      fontSize: 24,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Consumer<MainProvider>(
            builder: (_, pets, __) {
              print(pets.petsmodel);

              return (pets.petsmodel == null ||
                      pets.petsmodel.isEmpty) //Pet model can be empty too
                  ? SizedBox(
                      height: 60,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPet()));
                        },
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddPet()));
                            },
                            child: Icon(
                              Icons.add_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90),
                                    side: BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 120,
                      child: ListView.separated(
                        separatorBuilder: (_, __) {
                          return SizedBox(
                            width: 15,
                          );
                        },
                        padding: EdgeInsets.all(10),
                        itemCount: pets.petsmodel.length == 0
                            ? 1
                            : pets.petsmodel.length + 1,
                        itemBuilder: (context, index) {
                          if (index == pets.petsmodel.length) {
                            return SizedBox(
                              height: 50,
                            );
                          }
                          return InkWell(
                            onTap: () {
                              Alert(
                                context: context,
                                type: AlertType.none,
                                title: "Confirm",
                                desc: "Are you sure that you want to select " +
                                    (pets.petsmodel[index].petName.toString())
                                        .toString(),
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PetMatchScreen(
                                              category: pets
                                                  .petsmodel[index].category,
                                              subcategory: pets
                                                  .petsmodel[index].subcategory,
                                              gender:
                                                  pets.petsmodel[index].sex,),
                                        ),
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => CardPictures(),
                                      //   ),
                                      // );
                                    },
                                    width: 120,
                                  )
                                ],
                              ).show();
                            },
                            child: Container(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  pets.petsmodel[index].imageUrl[0].toString(),
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.4),
                              ),
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
