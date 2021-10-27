part of 'to_do_list.dart';

late String title;
String? description;
DateTime selectedDate = DateTime.now();
DateTime? from = selectedDate, to = selectedDate;
bool isDone = false;

class TaskEditor extends StatefulWidget {
  const TaskEditor({Key? key, this.task, required this.listModel}) : super(key: key);
  final Task? task;
  final ListModel listModel;

  @override
  _TaskEditorState createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    if(widget.task!=null){
      title = widget.task!.title;
      description = widget.task!.description;
      from = widget.task!.from;
      to = widget.task!.to;
      isDone = widget.task!.isDone;
    }else{
      title = "";
      description = null;
      from = null;
      to = null;
    }
    UniqueKey _formKey = UniqueKey();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add/Edit tasks"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              if(widget.task!=null){
                widget.listModel.deleteTask(widget.task!);
              }
              widget.listModel.addTask(
                  Task(
                      title: title,
                      isDone: isDone,
                      description: description,
                  )
              );
              Writer.upTasks(widget.listModel.tasks);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  initialValue: title,
                  decoration: const InputDecoration(
                    label: Text(
                        "Enter Task Title"
                    ),
                  ),
                  onChanged: (value){
                    title = value;
                  },
                ),
                // const Divider(),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: GestureDetector(
                //     child: Row(
                //       children: [
                //         const Text(
                //           "From",
                //           style: TextStyle(
                //             fontSize: 17,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.blueGrey,
                //           ),
                //         ),
                //         const Expanded(
                //           child: SizedBox(),
                //         ),
                //         Text(
                //           DateFormat('EEE, MMM dd yyyy')
                //               .format((from!=null)?from!:DateTime.now()),
                //         ),
                //       ],
                //     ),
                //     onTap: () async {
                //       selectedDate = await showDatePicker(
                //         context: context,
                //         initialDate: (from!=null)?from!:DateTime.now(),
                //         firstDate: DateTime(DateTime.now().year),
                //         lastDate: DateTime(2115),
                //       ) as DateTime;
                //       if(selectedDate!=from){
                //         setState(() {
                //           from = selectedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: GestureDetector(
                //     child: Row(
                //       children: [
                //         const Text(
                //           "To",
                //           style: TextStyle(
                //             fontSize: 17,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.blueGrey,
                //           ),
                //         ),
                //         const Expanded(
                //           child: SizedBox(),
                //         ),
                //         Text(
                //           DateFormat('EEE, MMM dd yyyy')
                //               .format((to!=null)?to!:DateTime.now()),
                //         ),
                //       ],
                //     ),
                //     onTap: () async {
                //       selectedDate = await showDatePicker(
                //         context: context,
                //         initialDate: (to!=null)?to!:DateTime.now(),
                //         firstDate: DateTime(DateTime.now().year),
                //         lastDate: DateTime(2115),
                //       ) as DateTime;
                //       if(selectedDate!=to){
                //         setState(() {
                //           to = selectedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),
                const Divider(),
                TextFormField(
                  initialValue: (description!=null)?description:"",
                  decoration: const InputDecoration(
                    label: Text(
                        "Description"
                    ),
                  ),
                  onChanged:(value){
                    description = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(
            Icons.delete_forever,
            color: Colors.black,
        ),
        onPressed: (){
          if(widget.task!=null){
            widget.listModel.deleteTask(widget.task!);
          }
          Writer.upTasks(widget.listModel.tasks);
          Navigator.pop(context);
        },
      ),
    );
  }
}