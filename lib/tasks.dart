import 'dart:io';

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:todoflask/connection.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    // TODO: implement initState
    method();
  }

  List Tasks = [];

  void method() async {
    var Todo = new todo();
    // await Todo.adduser("mahesh","chetan");
    Tasks = await Todo.gettodo(1);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox(
          height: double.infinity,
          child: ListView.builder(
              itemCount: Tasks.length,
              itemBuilder: (context, position) {
                return Taskcontainer(Tasks[position]["taskname"],
                    Tasks[position]["task"], Tasks[position]["id"]);
              }),
        ),
      ),
    );
  }

  Padding Taskcontainer(String taskname, String task, int task_id) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 3.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 3.0),
                    child: Text(
                      "Taskname:",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(taskname),
                  Padding(
                    padding: const EdgeInsets.only(left: 88.0),
                    child: IconButton(
                      onPressed: () async {
                        showDataAlert(task_id);
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: IconButton(
                      onPressed: () async {
                        var Todo = todo();
                        await Todo.deletetodo(task_id);
                        final materialBanner = MaterialBanner(

                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          forceActionsBelow: true,
                          content: AwesomeSnackbarContent(
                            title: 'Task deleted!!',
                            message:
                            'You have deleted $taskname Task successfully!',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.success,
                            // to configure for material banner
                            inMaterialBanner: true,
                          ),
                          actions: const [SizedBox.shrink()],
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentMaterialBanner()
                          ..showMaterialBanner(materialBanner);
                        Future.delayed(Duration(
                          seconds: 3,
                        ));
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 3.0),
                  child: Text(
                    "Task:",
                    style:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(child: Text(task)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showDataAlert(int task_id) {
    String tasname="";
    String tak="";
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
              ),
              contentPadding: EdgeInsets.only(
                top: 10.0,
              ),
              title: Text(
                "Update Task",
                style: TextStyle(fontSize: 24.0),
              ),
              content: Container(
                height: 300,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Enter Your Taskname ",
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Taskname here',
                              labelText: 'Taskname'),
                          onChanged: (value){
                            tasname=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Enter Your Task",
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Task here',
                              labelText: 'Task'),
                          onChanged: (value){
                            tak=value;
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async{
                            var Todo=todo();
                           await Todo.updatetodo(tasname, tak, task_id);
                            final materialBanner = MaterialBanner(

                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              forceActionsBelow: true,
                              content: AwesomeSnackbarContent(
                                title: 'Task Updated!!',
                                message:
                                'You have Updated $tasname Task successfully!',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.success,
                                // to configure for material banner
                                inMaterialBanner: true,
                              ),
                              actions: const [SizedBox.shrink()],
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentMaterialBanner()
                              ..showMaterialBanner(materialBanner);
                            Future.delayed(Duration(
                              seconds: 3,
                            ));

                            Navigator.pop(context);
                            Navigator.pop(context);

                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            // fixedSize: Size(250, 50),
                          ),
                          child: Text(
                            "Submit",
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
          );
        }
    );
  }
}
