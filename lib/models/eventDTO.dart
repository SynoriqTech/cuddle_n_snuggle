class EventDTO {
  int id;
  String title;
  String description;
  String eventDate;
  String time;

  EventDTO({required this.id, required this.title, required this.description, required this.eventDate, required this.time});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "eventDate": eventDate,
      "time": time
    };
  }
}
