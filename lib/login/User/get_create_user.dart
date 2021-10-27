import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  String? displayName = FirebaseAuth.instance.currentUser!.displayName;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference todo = FirebaseFirestore.instance.collection('todo');

  AppUser(){
    FirebaseFirestore.instance
        .collection('todo')
        .doc(userId).get()
        .then((DocumentSnapshot docSnapshot){
      if(!docSnapshot.exists){
        addUser();
      }
    });
  }
  void addUser(){
    addTodo();
  }

  Future<void> addTodo(){
    return todo
        .doc(userId)
        .set({
      "todolist": [],
    })
        .then((value) => print("User Todo Added"))
        .catchError((error) => print("Failed to Add user todo: $error"));
  }
}