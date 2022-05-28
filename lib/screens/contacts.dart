import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../http/remote.dart';
import 'contact_details.dart';
import '../model/user.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key, User}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<Contacts> {
  late List<int> contactList = [];
  User? user;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  getContacts() {
    setState(() {
      contactList = Remote.user.contacts!;
    });
  }

  addNewContact(String name) {
    /*
    Contact c = Contact(name);

    for (Contact ctg in contactList) {
      if (ctg.name == name) {
        return false;
      }
    }

    // TODO add remote


    contactList.add(c);
    return true;
    */
  }

  removeContact(int index) {
    /*
    Storage().deleteContact(contactList[index]);
    Remote().deleteContact(contactList[index]);

    setState(() {
      contactList = List.from(contactList)..removeAt(index);
    });

     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Contacts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Colors.black,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            _getListBox(),
            const Divider(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: _newContactButton(),
    );
  }

  Widget _newContactButton() {
    String input = "";
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: const Text('Add New Contact'),
          content: TextField(
            onChanged: (value) {
              input = value;
            },
            decoration: const InputDecoration(hintText: "Contact name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                input == ""
                    ? null
                    : setState(() {
                        addNewContact(input)
                            ? Navigator.pop(context, 'Add')
                            : null;
                      });
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      // Respond to button press
      child: const Icon(Icons.add),
    );
  }

  Widget _getListBox() {
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: ValueKey(contactList[index]),
            closeOnScroll: true,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListTile(
                tileColor: Colors.black87,
                leading: const Icon(Icons.contacts, color: Colors.white),
                //same over here
                title: Text(
                  "${contactList[index]}",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),

                trailing: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  //TODO: ContactDetails Sayfasıyla Bağla
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ContactDetails(id: contactList[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  key: ValueKey(contactList[index]),
                  autoClose: true,
                  onPressed: (context) {
                    removeContact(index);
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
