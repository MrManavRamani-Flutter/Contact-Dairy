import 'package:contact_diary/model/contact.dart';

class Global {
  static List<Contact> contactInfo = [
    Contact(
      pic: 'assets/pic/user.png',
      name: 'Manav',
      contact: '7096584269',
      email: 'manav@gmail.com',
    ),
    Contact(
      pic: 'assets/pic/user.png',
      name: 'Raj',
      contact: '9196584262',
      email: 'raj@gmail.com',
    ),
  ];
  static List<Contact> find = [];
}
