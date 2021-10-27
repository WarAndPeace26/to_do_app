import 'package:flutter/material.dart';
import 'package:to_do_app/login/fireabase-interaction/read.dart';
import 'package:to_do_app/utilities/models/data_classes.dart';

class ListModel extends ChangeNotifier{

  List<Task> tasks = [];
  ListModel(){
    Reader.readAllTasks().then((value){
      tasks = value;
    });
  }

  void addTask(Task task){
    tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task){
    tasks.remove(task);
    notifyListeners();
  }
}
