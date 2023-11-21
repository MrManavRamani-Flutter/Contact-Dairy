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
      res = Global.contactInfo.where((e) => e.name.contains(val)).toList();
    }
    setState(() {
      Global.find = res;
    });
  }

  TextEditingController festQuoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Add Quote',
                ),
                content: TextField(
                  controller: festQuoteController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Quote',
                  ),
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      // Global.fest_quote = festQuoteController.text;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text('Done'),
                  ),
                ],
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
                  TextField(
                    onChanged: (val) => filterData(val),
                    decoration: const InputDecoration(
                        labelText: 'Search', suffixIcon: Icon(Icons.search)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: Global.find.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(Global.find[index].name),
                        // color: Colors.blue,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('viewContact',
                                arguments: Global.find[index]);
                          },
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Image(
                                  image: AssetImage('assets/pic/user.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              Global.find[index].name.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                // color: Colors.white,
                              ),
                            ),
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
                ],
              ),
            ),
    );
  }
}
