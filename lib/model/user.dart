class User {
  late int id;
  String name;
  String surname;
  String phone;
  String? email;
  String? linkedin;
  String? company;

  User(this.name, this.surname, this.phone, {email, linkedin, company});

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json['name'],
        surname = json['surname'],
        phone = json['phone'],
        email = json['email'],
        linkedin = json['linkedin'],
        company = json['company'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "phone": phone,
        "email": email,
        "linkedin": linkedin,
        "company": company,
      };
}
