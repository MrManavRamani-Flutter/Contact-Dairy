import 'package:contact_diary/model/contact.dart';
import 'package:flutter/material.dart';

class ViewContactInfo extends StatefulWidget {
  const ViewContactInfo({super.key});

  @override
  State<ViewContactInfo> createState() => _ViewContactInfoState();
}

class _ViewContactInfoState extends State<ViewContactInfo> {
  @override
  Widget build(BuildContext context) {
    Contact viewContact = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Contact Info'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        width: double.infinity,
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                margin: const EdgeInsets.all(15),
                color: Colors.black12,
                height: 230,
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(viewContact.pic),
                  fit: BoxFit.cover,
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
                            size: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
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
                            size: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
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
                            size: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
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
          ],
        ),
      ),
    );
  }
}
