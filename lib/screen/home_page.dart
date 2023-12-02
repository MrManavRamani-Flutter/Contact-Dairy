import 'package:contact_diary/provider/add_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    var addDataPFalse = Provider.of<AddDataProvider>(context, listen: false);
    return Scaffold(
      //  App Bar.....................................................
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        elevation: 18,
        actions: [
          (addDataP.hideContact.isEmpty)
              ? const Text('')
              : TextButton(
                  onPressed: () async {
                    LocalAuthentication localAuth = LocalAuthentication();
                    if (await localAuth.canCheckBiometrics &&
                        await localAuth.isDeviceSupported()) {
                      localAuth
                          .authenticate(localizedReason: 'Unlock hide Contact')
                          .then((value) {
                        Navigator.of(context).pushNamed('hideContact');
                      });
                    }
                  },
                  child: const Text('Hide'),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const Alert();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: (addDataP.allContact.isEmpty)
          ? Container(
              alignment: Alignment.center,
              color: Colors.black12,
              child: const Text(
                'No Contact',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: addDataP.allContact
                          .map(
                            (e) => Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              elevation: 9,
                              child: ListTile(
                                // Long Press for Delete Contact...........
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete Contact'),
                                        content: const Text(
                                            'Are You Sure To Delete Contact..!'),
                                        actions: [
                                          // Delete Button..............
                                          ElevatedButton(
                                            onPressed: () {
                                              addDataP.deleteContact(e);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete'),
                                          ),
                                          // Cancel Button.............
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                // On Tap To Goto Contact View Page
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('viewContact', arguments: e);
                                },
                                leading: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 50,
                                  width: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2, color: Colors.black54),
                                  ),
                                  // Image......................................
                                  child: (e.pic != null)
                                      ? CircleAvatar(
                                          backgroundImage: FileImage(e.pic!),
                                        )
                                      : const CircleAvatar(
                                          child: FlutterLogo(),
                                        ),
                                ),
                                // Name ........................................
                                title: Text(
                                  e.name,
                                ),
                                // Number ......................................
                                subtitle: Text(
                                  e.contact,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Call....
                                    IconButton(
                                        onPressed: () async {
                                          final Uri url =
                                              Uri.parse('tel:${e.contact}');
                                          await launchUrl(url);
                                        },
                                        icon: const Icon(
                                          Icons.call,
                                          size: 30,
                                        )),
                                    // Message
                                    IconButton(
                                        onPressed: () async {
                                          final Uri url =
                                              Uri.parse('sms:${e.contact}');
                                          await launchUrl(url);
                                        },
                                        icon: const Icon(
                                          Icons.sms,
                                          size: 30,
                                        )),
                                    //   Hide....
                                    IconButton(
                                      onPressed: () {
                                        addDataPFalse.hideContactData(e);
                                      },
                                      icon: const Icon(Icons.lock),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({super.key});
  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    return AlertDialog(
      title: const Text(
        'Add Contact',
      ),
      content: SizedBox(
        height: 455,
        width: 400,
        child: Stepper(
          controlsBuilder: (context, details) {
            if (addDataP.cs.currentStep == 0) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                ],
              );
            } else if (addDataP.cs.currentStep == 3) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkFillData();
                      addDataP.checkContinueState();
                      Navigator.pop(context);
                      addDataP.cs.currentStep = 0;
                    },
                    child: const Text('Finish'),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            }
          },
          currentStep: addDataP.cs.currentStep,
          steps: <Step>[
            Step(
              state: (addDataP.cs.currentStep == 0)
                  ? StepState.editing
                  : (addDataP.con_var.nameC.text.isEmpty)
                      ? StepState.error
                      : StepState.complete,
              title: const Text('Name'),
              content: TextField(
                controller: addDataP.con_var.nameC,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 1)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 1)
                      ? StepState.editing
                      : (addDataP.con_var.emailC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Email'),
              content: TextField(
                controller: addDataP.con_var.emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Enter your Email'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 2)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 2)
                      ? StepState.editing
                      : (addDataP.con_var.contactC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Contact'),
              content: TextField(
                onSubmitted: (val) {
                  addDataP.con_var.contactC.text = val;
                },
                keyboardType: TextInputType.phone,
                controller: addDataP.con_var.contactC,
                maxLength: 10,
                decoration:
                    const InputDecoration(hintText: 'Enter your Contact'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 3)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 3)
                      ? StepState.editing
                      : (addDataP.con_var.contactC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Profile Pic'),
              content: Row(
                children: [
                  (addDataP.pickImage != null)
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage: FileImage(addDataP.pickImage!),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          child: FlutterLogo(),
                        ),
                  IconButton(
                      onPressed: () {
                        addDataP.imagePic();
                      },
                      icon: const Icon(Icons.photo)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
