import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/utilities/models/data_classes.dart';

class Writer{

  static List<Map<String,dynamic>> allTasks = <Map<String,dynamic>>[];

  static CollectionReference toDo = FirebaseFirestore.instance.collection('todo');


  static void allToJson(List<Task> tasksList){
    allTasks = [];
    tasksList.forEach(
            (task) {
              allTasks.add(task.toJson());
            });
  }

  static Future<void> upTasks(List<Task> tasksList) {
    allToJson(tasksList);
    return toDo
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'todolist': allTasks})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}