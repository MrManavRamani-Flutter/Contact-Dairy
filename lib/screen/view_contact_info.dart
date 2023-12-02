// ignore_for_file: must_be_immutable

import 'package:contact_diary/model/contact.dart';
import 'package:contact_diary/provider/add_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewContactInfo extends StatelessWidget {
  const ViewContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    var addDataPFalse = Provider.of<AddDataProvider>(context, listen: false);
    Contact viewContact = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Contact'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 850,
          // color: Colors.black12,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: (addDataP.pickImage != null)
                        ? CircleAvatar(
                            backgroundImage: FileImage(addDataP.pickImage!),
                            radius: 150,
                          )
                        : const FlutterLogo(size: 250),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // Name Data.............
                            Text(
                              viewContact.name,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.call,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // Contact Data ................
                            Text(
                              viewContact.contact,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email_rounded,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // Email Data ................
                            Text(
                              viewContact.email,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          addDataP.deleteContact(viewContact);
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          addDataP.con_edit_var.nameCE.text = viewContact.name;
                          addDataP.con_edit_var.emailCE.text =
                              viewContact.email;
                          addDataP.con_edit_var.contactCE.text =
                              viewContact.contact;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Update Contact"),
                                actions: [
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel")),
                                  ElevatedButton(
                                      onPressed: () {
                                        addDataPFalse.checkEditFillData(
                                            viewContact,
                                            addDataP.con_edit_var.nameCE.text,
                                            addDataP.con_edit_var.emailCE.text,
                                            addDataP
                                                .con_edit_var.contactCE.text);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Done")),
                                ],
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Name"),
                                    TextField(
                                      controller: addDataP.con_edit_var.nameCE,
                                      keyboardType: TextInputType.text,
                                    ),
                                    const Text("Contact"),
                                    TextField(
                                      maxLength: 10,
                                      keyboardType: TextInputType.phone,
                                      controller:
                                          addDataP.con_edit_var.contactCE,
                                    ),
                                    const Text("Email"),
                                    TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: addDataP.con_edit_var.emailCE,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class EditAlert extends StatelessWidget {
//   Contact editData;
//   EditAlert({super.key, required this.editData});
//
//   @override
//   Widget build(BuildContext context) {
//     var addDataP = Provider.of<AddDataProvider>(context);
//     return AlertDialog(
//       actions: [
//         Container(
//           alignment: Alignment.center,
//           height: 35,
//           child: ElevatedButton(
//               onPressed: () {
//                 addDataP.checkEditFillData(
//                     editData,
//                     addDataP.con_edit_var.nameCE.text,
//                     addDataP.con_edit_var.emailCE.text,
//                     addDataP.con_edit_var.contactCE.text);
//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 'Update',
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               )),
//         ),
//       ],
//       content: Container(
//         height: 300,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Add Contact',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//               // Name :
//               const Text(
//                 'Name : ',
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//               TextField(
//                 controller: addDataP.con_edit_var.nameCE,
//                 decoration: InputDecoration(
//                   hintText: editData.name,
//                   border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(2),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               // Email :
//               const Text(
//                 'Email : ',
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//
//               TextField(
//                 controller: addDataP.con_edit_var.emailCE,
//                 decoration: InputDecoration(
//                     hintText: editData.email,
//                     border: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(2)))),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               // Contact :
//               const Text(
//                 'Contact : ',
//                 style: TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//
//               TextField(
//                 controller: addDataP.con_edit_var.contactCE,
//                 decoration: InputDecoration(
//                     hintStyle: const TextStyle(fontSize: 15),
//                     hintText: editData.contact,
//                     border: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(2)))),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
