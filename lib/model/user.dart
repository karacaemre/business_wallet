import 'event.dart';

class User {
  late int id;
  String name;
  String surname;
  String phone;
  String? email;
  String? linkedin;
  String? company;
  List<User>? contacts;
  List<Event>? pastEvents;

  User(this.name, this.surname, this.phone,
      {email, linkedin, company, pastEvents, contacts});

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json['name'],
        surname = json['surname'],
        phone = json['phone'],
        email = json['email'],
        linkedin = json['linkedin'],
        company = json['company'],
        pastEvents = json['past_events'],
        contacts = json['contacts'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "phone": phone,
        "email": email,
        "linkedin": linkedin,
        "company": company,
        "past_events": pastEvents,
        "contacts": contacts
      };

  void addContact(User u) {
    if (contacts == null) {
      contacts = List<User>.filled(1, u);
    } else {
      contacts?.add(u);
    }
  }

  List<User>? getContacts() {
    return contacts;
  }

  void deleteContact(int id) {
    contacts?.removeWhere((user) => user.id == id);
  }

  List<Event>? getPastEvents() {
    return pastEvents;
  }
}
