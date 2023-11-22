import 'package:contact_diary/model/contact.dart';
import 'package:contact_diary/utils/global.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Global.find = Global.contactInfo;
    super.initState();
  }

  void filterData(String val) {
    List<Contact> res = [];
    if (val.isEmpty) {
      res = Global.contactInfo;
    } else {
      res = Global.contactInfo.where((e) {
        return e.name.contains(val);
      }).toList();
    }
    setState(() {
      Global.find = res;
    });
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController contactC = TextEditingController();

  TextEditingController festQuoteController = TextEditingController();
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  App Bar.....................................................
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        elevation: 18,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      // TODO: Add Contact .................................................
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Add Contact',
                ),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return SizedBox(
                      height: 400,
                      width: 400,
                      child: Stepper(
                        controlsBuilder: (context, details) {
                          if (currentStep == 0) {
                            return Row(
                              children: [
                                FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      if (currentStep < 2) {
                                        currentStep++;
                                      }
                                    });
                                  },
                                  child: const Text('Continue'),
                                ),
                              ],
                            );
                          } else if (currentStep == 2) {
                            return Row(
                              children: [
                                FilledButton(
                                  onPressed: () {
                                    if (currentStep < 2) {
                                      currentStep++;
                                    }
                                    setState(() {});
                                  },
                                  child: const Text('Finish'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (currentStep > 0) {
                                        currentStep--;
                                      }
                                    });
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
                                    setState(() {
                                      if (currentStep < 2) {
                                        currentStep++;
                                      }
                                    });
                                  },
                                  child: const Text('Continue'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (currentStep > 0) {
                                        currentStep--;
                                      }
                                    });
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          }
                        },
                        currentStep: currentStep,
                        // onStepContinue: () {
                        //   setState(() {
                        //     if (currentStep < 2) {
                        //       currentStep++;
                        //     }
                        //   });
                        // },
                        // onStepCancel: () {
                        //   setState(() {
                        //     if (currentStep > 0) {
                        //       currentStep--;
                        //     }
                        //   });
                        // },
                        steps: <Step>[
                          Step(
                            state: (currentStep == 0)
                                ? StepState.editing
                                : (nameC.text.isEmpty)
                                    ? StepState.error
                                    : StepState.complete,
                            title: const Text('Name'),
                            content: TextField(
                              controller: nameC,
                              decoration: const InputDecoration(
                                  hintText: 'Enter your name'),
                            ),
                          ),
                          Step(
                            state: (currentStep < 1)
                                ? StepState.indexed
                                : (currentStep == 1)
                                    ? StepState.editing
                                    : (emailC.text.isEmpty)
                                        ? StepState.error
                                        : StepState.complete,
                            title: const Text('Email'),
                            content: TextField(
                              controller: emailC,
                              decoration: const InputDecoration(
                                  hintText: 'Enter your Email'),
                            ),
                          ),
                          Step(
                            state: (currentStep < 2)
                                ? StepState.indexed
                                : (currentStep == 2)
                                    ? StepState.editing
                                    : (contactC.text.isEmpty)
                                        ? StepState.error
                                        : StepState.complete,
                            title: const Text('Contact'),
                            content: TextField(
                              controller: contactC,
                              decoration: const InputDecoration(
                                  hintText: 'Enter your Contact'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: (Global.contactInfo.isEmpty)
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onChanged: (val) => filterData(val),
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(23),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(thickness: 3),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: Global.find.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(Global.find[index].name),
                          // color: Colors.blue,
                          // elevation: 9,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('viewContact',
                                  arguments: Global.find[index]);
                            },
                            child: Card(
                              elevation: 9,
                              child: ListTile(
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
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: Image(
                                      image: AssetImage('assets/pic/user.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Name ........................................
                                title: Text(
                                  Global.find[index].name.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    // color: Colors.white,
                                  ),
                                ),
                                // Number ......................................
                                subtitle: Text(
                                  Global.find[index].contact.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
