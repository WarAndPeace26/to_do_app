import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/login/fireabase-interaction/read.dart';
import 'list_model.dart';
import 'package:to_do_app/utilities/models/data_classes.dart';
import 'package:intl/intl.dart';
import '../../login/fireabase-interaction/write.dart';

part 'task_handling.dart';



class ListPage extends StatelessWidget {
  const ListPage({Key? key, required this.signOut}) : super(key: key);
  final Function signOut;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => ListModel(),
        builder: (context, _ ) => MyToDoList(signOut: signOut,),
      ),
    );
  }
}


class MyToDoList extends StatefulWidget {
  const MyToDoList({Key? key, required this.signOut}) : super(key: key);
  final Function signOut;
  @override
  State<MyToDoList> createState() => _MyToDoListState();
}
class _MyToDoListState extends State<MyToDoList> {

  @override
  Widget build(BuildContext context) {
    Future future = Reader.readAllTasks();
    return Consumer<ListModel>(
      builder: (context, toDoList, child){
        return Scaffold(
          appBar: AppBar(
            title: const Text("To Do list"),
            actions: [
              IconButton(
                  onPressed: () {
                    widget.signOut();
                  },
                  icon: const Icon(
                    Icons.exit_to_app_outlined
                  )
              ),
            ],
          ),
          body: FutureBuilder(
            future: future,
            builder: (context, snapshot){
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return ListView.builder(
                    itemCount: toDoList.tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: GestureDetector(
                            child: Text(
                              toDoList.tasks[index].title,
                              style: TextStyle(
                                decoration: toDoList.tasks[index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TaskEditor(
                                      task: toDoList.tasks[index],
                                      listModel: toDoList,
                                    );
                                  });
                            }),
                        trailing: TaskCheckBox(
                          toDoList: toDoList,
                          index: index,
                        ),
                      );
                    },
                  );
                default:
                  return const Text('Something went wrong');
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return TaskEditor(listModel: toDoList,);
                  });
            },
          ),
        );
      },
    );
  }
}

class TaskCheckBox extends StatefulWidget {
  const TaskCheckBox({Key? key, required this.toDoList, required this.index}) : super(key: key);
  final ListModel toDoList;
  final int index;
  @override
  _TaskCheckBoxState createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: widget.toDoList.tasks[widget.index].isDone,
        onChanged: (isDoneYet) {
          setState(() {
            widget.toDoList.tasks[widget.index].isDone = isDoneYet!;
          });
        });
  }
}
