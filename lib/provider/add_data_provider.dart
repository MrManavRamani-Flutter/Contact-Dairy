// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:contact_diary/model/contact.dart';
import 'package:contact_diary/model/controller_var.dart';
import 'package:contact_diary/model/current_step.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDataProvider extends ChangeNotifier {
  // Create Obj of Current Step of Editing.............
  CurrentStep cs = CurrentStep(currentStep: 0);
  // Hide contact List :-
  List<Contact> hideContact = [];
  // List Of All Contact
  List<Contact> allContact = [
    // Contact(
    //     pic: 'assets/pic/user.png',
    //     name: 'Manav',
    //     contact: '7096584269',
    //     email: 'manav@gmail.com'),
    // Contact(
    //     pic: 'assets/pic/user.png',
    //     name: 'Harsh',
    //     contact: '8128895379',
    //     email: 'Harsh@gmail.com'),
  ];

  // TextEditing Controller Obj.................
  ControllerVar con_var = ControllerVar(
      nameC: TextEditingController(text: ''),
      emailC: TextEditingController(text: ''),
      contactC: TextEditingController(text: ''));
  // TextEditing Controller Obj.................
  ControllerEditVar con_edit_var = ControllerEditVar(
      nameCE: TextEditingController(text: ''),
      emailCE: TextEditingController(text: ''),
      contactCE: TextEditingController(text: ''));

  // Add Contact Data..........
  void addContact(String name, String contact, String email) {
    Contact data = Contact(name: name, contact: contact, email: email);
    allContact.add(data);
    notifyListeners();
  }

  void addData(String name, String contact, String email, File imagePic) {
    Contact data =
        Contact(pic: pickImage!, name: name, contact: contact, email: email);
    allContact.add(data);
    notifyListeners();
  }

  // Gallery Pic :-------
  File? pickImage;
  imagePic() async {
    final ImagePicker picker = ImagePicker();

    XFile? res = await picker.pickImage(source: ImageSource.gallery);
    String? path = res!.path;
    pickImage = File(path);
    notifyListeners();
  }

  // Check Fill Data Or Not ...................
  checkFillData() {
    if (con_var.nameC.text.isNotEmpty &&
        con_var.emailC.text.isNotEmpty &&
        con_var.contactC.text.isNotEmpty &&
        pickImage != null) {
      addData(con_var.nameC.text, con_var.contactC.text, con_var.emailC.text,
          pickImage!);
    } else if (con_var.nameC.text.isNotEmpty &&
        con_var.emailC.text.isNotEmpty &&
        con_var.contactC.text.isNotEmpty) {
      addContact(
          con_var.nameC.text, con_var.contactC.text, con_var.emailC.text);

      con_var.contactC.clear();
      con_var.nameC.clear();
      con_var.emailC.clear();
      pickImage = null;
    }
    notifyListeners();
  }

  // Check Edit Fill Data Or Not ...................
  checkEditFillData(
      Contact oldData, String name, String email, String contact) {
    if (allContact.contains(oldData)) {
      allContact.forEach((element) {
        if (element == oldData) {
          element.name = name;
          element.email = email;
          element.contact = contact;
        }
      });
    }
    con_edit_var.contactCE.clear();
    con_edit_var.nameCE.clear();
    con_edit_var.emailCE.clear();
    notifyListeners();
  }

  // Delete Contact Function.......
  deleteContact(Contact data) {
    // Add Contact Data..........
    allContact.remove(data);
    notifyListeners();
  }

  checkContinueState() {
    if (cs.currentStep < 3) {
      cs.currentStep++;
    }
    notifyListeners();
  }

  checkCancelState() {
    if (cs.currentStep > 0) {
      cs.currentStep--;
    }
    notifyListeners();
  }

  void hideContactData(Contact data) {
    hideContact.add(data);
    allContact.remove(data);
    notifyListeners();
  }

  void unhideContactData(Contact data) {
    allContact.add(data);
    hideContact.remove(data);
    notifyListeners();
  }
}
