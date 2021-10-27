import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/utilities/models/data_classes.dart';

class Reader{

  static Map<String, dynamic>? allTasks;


  static Future<List<Task>> readAllTasks() async {
    List<Task> tasks = [];
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore
        .instance
        .collection('todo')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        allTasks = documentSnapshot.data() as Map<String,dynamic>;
      }
    });
    allTasks!["todolist"].forEach(
            (jsonTask){
              tasks.add(Task.fromJson(jsonTask));
            });
    return tasks;
  }

}
