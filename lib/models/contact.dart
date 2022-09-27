class Contact {
  int? id;
  String? name;
  String? date;
  int? number;
  int? password;
  String? nametype;
  String? category;

  Contact({
    this.id,
    this.number,
    this.name,
    this.date,
    this.password,
    this.nametype,
    this.category,
  });

  Contact.fromMap(dynamic obj) {
    this.id = obj['contactId'];
    this.number = obj['numbers'];
    this.name = obj['contactName'];
    this.date = obj['contactDate'];
    this.password = obj['passwords'];
    this.nametype = obj['contactType'];
    this.category = obj['FK_contact_category'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'contactName': name,
      'numbers': number,
      'contactDate': date,
      'passwords': password,
      'contactType': nametype,
      'FK_contact_category': category,
    };
    return map;
  }
}
