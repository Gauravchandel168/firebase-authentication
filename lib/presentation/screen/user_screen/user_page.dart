import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firestore_page/firestore_page.dart';

class UserPageState extends StatefulWidget {
  UserPageState({Key? key}) : super(key: key);

  @override
  State<UserPageState> createState() => _UserPageStateState();
}

final ControllerName = TextEditingController();
final ControllerAge = TextEditingController();
final ControllerDate = TextEditingController();

class _UserPageStateState extends State<UserPageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add user"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: ControllerName,
            decoration: InputDecoration(hintText: "Name"),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: ControllerAge,
            decoration: InputDecoration(hintText: "Age"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: ControllerDate,
            decoration: InputDecoration(hintText: "Birthday"),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                final user = User(
                  name: ControllerName.text,
                  age: int.parse(ControllerAge.text),
                  birthday: DateTime.now(),
                );
                createUser(user);
              },
              child: Text("Create")),
        ],
      ),
    );
  }

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
