class Event {
  int id;
  String name;
  String? description;
  List<int>? organizers;
  List<int>? attendees;

  Event.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        organizers = json["organizers"].cast<int>(),
        attendees = json["attendees"].cast<int>();

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "organizers": organizers,
        "attendees": attendees,
      };
}
