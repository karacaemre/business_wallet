import 'dart:convert';

class User {
  late int id;
  String name;
  String surname;
  String phone;
  String? email;
  String? linkedin;
  String? company;
  List<int>? contacts;

  User(this.name, this.surname, this.phone,
      {email, linkedin, company, pastEvents, contacts});

  User.fromJson(Map<String, dynamic> json)
      : id = json["ID"],
        name = json['name'],
        surname = json['surname'],
        phone = json['phone'],
        email = json['email'],
        linkedin = json['linkedin'],
        company = json['company'],
        contacts = json['contacts']?.cast<int>();

  Map<String, dynamic> toJson() => {
        "ID": id,
        "name": name,
        "surname": surname,
        "phone": phone,
        "email": email,
        "linkedin": linkedin,
        "company": company,
        "contacts": contacts
      };

  String toJsonString() {
    return jsonEncode(this);
  }

  void addContact(int id) {
    if (contacts == null) {
      contacts = List<int>.filled(1, id);
    } else {
      contacts?.add(id);
    }
  }

  List<int>? getContacts() {
    return contacts;
  }

  void deleteContact(int id) {
    contacts?.remove(id);
  }
}
