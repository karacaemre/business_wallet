class Event {
  late int id;
  String name;
  String description;
  late int organizer;
  List<int>? attendees;
  DateTime start;
  DateTime finish;

  Event(this.name, this.description, this.start, this.finish);

  Event.fromJson(Map<String, dynamic> json)
      : id = json["ID"],
        name = json["name"],
        description = json["description"],
        organizer = json["organizer"],
        attendees = json["attendees"].cast<int>(),
        start = DateTime.parse(json["start"]),
        finish = DateTime.parse(json["finish"]);

  Map<String, dynamic> toJson() =>
      {
        "ID": id,
        "name": name,
        "description": description,
        "organizer": organizer,
        "attendees": attendees,
        "start": start.toUtc().toIso8601String(),
        "finish": finish.toUtc().toIso8601String(),
      };

  Map<String, dynamic> toCreateRequest() =>
      {
        "name": name,
        "description": description,
        "start": start.toUtc().toIso8601String(),
        "finish": finish.toUtc().toIso8601String(),
      };
}

