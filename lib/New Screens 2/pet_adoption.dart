import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:cns/New%20Screens%202/chat.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';
class PetAdoption extends StatefulWidget {
  @override
  _PetAdoptionState createState() => _PetAdoptionState();
}

class _PetAdoptionState extends State<PetAdoption> {
  bool exceedSwipes = true;
  @override
  Widget build(BuildContext context) {
    CardController controller;

    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GradientAppBar("Pet Adoption"),
                Consumer<MainProvider>(
                  builder: (_, petsadoption, __) {
                    petsadoption.petadoption;
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );

                        },
                        itemCount: petsadoption.pet_adoption_model.length,

                        itemBuilder: (context, index) {

                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0 , right : 16.0 , bottom: 4.0),
                            child: Card(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                            petsadoption.pet_adoption_model[index].imageUrl[0]
                                                .toString(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Column(


                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              petsadoption.pet_adoption_model[index].petName
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .merge(TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              petsadoption.pet_adoption_model[index].age
                                                  .toString() +
                                                  " Years",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .merge(TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "${petsadoption.pet_adoption_model[index].about}",
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .merge(TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Consumer<MainProvider>(
                                      builder: (_, account, __) {
                                        return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ChatPage(
                                                      sender: account.currentUser,
                                                      imageUrl: account
                                                          .pet_adoption_model[index]
                                                          .imageUrl[0]
                                                          .toString(),
                                                      second_id: account
                                                          .pet_adoption_model[index]
                                                          .id
                                                          .toString(),
                                                      second_name: account
                                                          .pet_adoption_model[index]
                                                          .petName
                                                          .toString(),
                                                      chatId: chatId(
                                                        account.currentUser.id,
                                                        account
                                                            .pet_adoption_model[
                                                                index]
                                                            .id,
                                                      ),
                                                    ),
                                                  ));
                                            },
                                            child: Icon(Icons.messenger_outline));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
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
                Navigator.of(context).pop();
              },
            ),
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
            Color(0xff01b4c9),
          ],
        ),
      ),
    );
  }
}

var groupChatId;
chatId(currentUser, sender) {
  if (currentUser.hashCode <= sender.hashCode) {
    return groupChatId = '$currentUser-$sender';
  } else {
    return groupChatId = '$sender-$currentUser';
  }
}
