import 'package:flutter/material.dart';
import 'package:cns/custom_widgets/custom_button.dart';
import 'package:cns/mixins/validation_mixin.dart';
import 'package:cns/models/event.dart';
import 'package:cns/services/db_service.dart';
import 'package:cns/util/database_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cns/main.dart';
import 'package:cns/New Screens 2/Calenderx.dart';

class AddEvent extends StatefulWidget {
  final EventModel? event;

  AddEvent({this.event});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> with ValidationMixin {
  late DbService dbService;
  late DatabaseHelper databaseHelper;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _description;
  late DateTime _eventDate;
  late TimeOfDay _time;
  late bool processing;
  String header = "Add New Reminder";
  String buttonText = "Save";
  bool addNewTask = true;

  @override
  void initState() {
    super.initState();
    dbService = DbService();
    databaseHelper = DatabaseHelper();
    _title = TextEditingController();
    _description = TextEditingController();
    _eventDate = DateTime.now();
    _time = TimeOfDay.now();
    if (widget.event != null) {
      populateForm();
    }
    processing = false;
  }

  void populateForm() {
    _title.text = widget.event!.title;
    _description.text = widget.event!.description;
    _eventDate = widget.event!.eventDate;
    _time = widget.event!.time!;
    header = "Update Appointment";
    buttonText = "Update";
    addNewTask = false;
    setState(() {
      // updatenotification();
    });
  }

  void saveTask() async {
    try {
      if (addNewTask) {
        await databaseHelper.addTask(EventModel(
          title: _title.text,
          description: _description.text,
          eventDate: _eventDate,
          time: _time,
        ));
      } else {
        await databaseHelper.updateTask(EventModel(
            id: widget.event!.id,
            title: _title.text,
            description: _description.text,
            eventDate: _eventDate,
            time: _time));
      }

      setState(() {
        processing = false;
      });
      await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  void deleteTask() async {
    try {
      await databaseHelper.deleteTask(widget.event!.id!);
      setState(() {
        processing = false;
      });
      await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  Future<bool> _goBack() async {
    Navigator.of(context).pop(true);
    return false;
  }

  Future<bool> _onBackPressedWithButton() async {
    Navigator.of(context).pop(false);
    return false;
  }

  void scheduleNotification() async {
    var scheduleTime =
        _eventDate.add(Duration(hours: _time.hour - 1, minutes: _time.minute));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'download',
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      // largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        // sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutternotificationplugin.schedule(
      1 +
          int.parse(
              scheduleTime.microsecondsSinceEpoch.toString().substring(0, 7)),
      'Reminder',
      'You will be reminded 1 hour before your scheduled appointment',
      DateTime.now().add(
        Duration(seconds: 15),
      ),
      platformChannelSpecifics,
    );
    await flutternotificationplugin.schedule(
      int.parse(scheduleTime.microsecondsSinceEpoch.toString().substring(0, 7)),
      'Reminder',
      'You have upcoming appointment @${widget.event!.title} in 1 hour',
      scheduleTime,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressedWithButton,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomLeft,
              height: 80,
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _onBackPressedWithButton();
                  }),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(header,
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
            Expanded(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: TextFormField(
                            controller: _title,
                            validator: validateTextInput,
                            decoration: InputDecoration(
                                labelText: "Title",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _description,
                            minLines: 3,
                            maxLines: 5,
                            validator: validateTextInput,
                            decoration: InputDecoration(
                                labelText: "description",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: Text("Date of Appointment"),
                          subtitle: Text(
                              "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _eventDate,
                                firstDate: DateTime(_eventDate.year - 5),
                                lastDate: DateTime(_eventDate.year + 5));
                            if (picked != null) {
                              setState(() {
                                _eventDate = picked;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          title: Text("Time of Appointment"),
                          subtitle: Text(_time.format(context)),
                          onTap: () async {
                            TimeOfDay? picked = await showTimePicker(
                                context: context, initialTime: _time);

                            if (picked != null) {
                              setState(() {
                                _time = picked;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        processing
                            ? Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    CustomButton(
                                      buttonText: buttonText,
                                      width: MediaQuery.of(context).size.width,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            processing = true;
                                          });
                                          saveTask();
                                          scheduleNotification();
                                        }
                                      },
                                      key: Key("B"), buttonIcon: Text("Update"),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: !addNewTask
                                          ? CustomButton(
                                              buttonText: "Delete",
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              buttonColor: Colors.redAccent,
                                              onPressed: () async {
                                                setState(() {
                                                  processing = true;
                                                });
                                                deleteTask();
                                              }, buttonIcon: Text("Delete"), key: Key("L"),)
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
