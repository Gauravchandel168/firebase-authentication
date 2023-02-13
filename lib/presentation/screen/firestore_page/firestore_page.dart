import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise_functionality_screen/presentation/screen/user_screen/user_page.dart';

import '../../router/app_routes_utills.dart';

class FirestorePage extends StatefulWidget {
   FirestorePage({Key? key}) : super(key: key);

  @override
  State<FirestorePage> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
final controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body:StreamBuilder<List<User>>(stream:readUsers(),
    builder:(context,snapshot){
      if(snapshot.hasError) {
        return Text("Something went wrong! ${snapshot.error}");
      } else if(snapshot.hasData){
          final users=snapshot.data!;

          return ListView(
            children:users.map(buildUsers).toList(),
          );
        }else{
      return Center(child:CircularProgressIndicator());
      }
    }
  ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          navigatorKey.currentState?.push(MaterialPageRoute(builder: (context)=>UserPageState(),));
        },
      ),
      );
}
Widget buildUsers(User user)=>ListTile(
  leading: CircleAvatar(child: Text("${user.age}"),),
  title: Text(user.name??""),
  subtitle: Text("user.birthday.toIso8601String())"),
);


Stream<List<User>>readUsers()=>FirebaseFirestore.instance.collection("users").snapshots().map((snapshot) =>
    snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
Future createUser({required String name}) async{

  //Reffernce to doument get that code from ducument
  final docUser=FirebaseFirestore.instance.collection("users").doc();

  final user =User(
    id: docUser.id,
    name:name,
    age:21,
    birthday:DateTime(2001,7,28),
  );
  final json=user.toJson();
// to create next  document in collection and write data to firebase automatically documrnt name create and all document name
  await docUser.set(json);
}
}

// ::::This is Separate class:::::

class User{
  String? id;
  final String? name;
  final int? age;
  final DateTime? birthday;

  User({
    this.id="",
     required this.name,
   required this.age,
     required this.birthday,
});

  Map<String,dynamic> toJson() => {
    'id':id,
    'name':name,
    'age':age,
    'birthday':birthday,
  };

  static User fromJson(Map<String,dynamic>json)=>User(
    id:json ['id'],
    name:json ['name'],
    age:json ['age'],
    birthday:(json['birthday']as Timestamp?)?.toDate(),
  );

}
