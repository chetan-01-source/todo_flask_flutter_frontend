import 'package:todoflask/constants..dart';
import 'package:flutter/material.dart';
import 'package:todoflask/Model/todoitem.dart';
import 'package:todoflask/connection.dart';
import 'tasks.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState(){
    var Todo=todo();

    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Starttodo(),
      routes: {
        'TaskScreen':(context)=>  TaskPage(),
        'home':(context)=> MyApp(),
      },
    );
  }

}


class Starttodo extends StatefulWidget {
  const Starttodo({super.key});

  @override
  State<Starttodo> createState() => _StarttodoState();
}

class _StarttodoState extends State<Starttodo> {
  @override
  String taskname="";
  String task="";
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title:Text("Todo app") ,
            centerTitle:true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          taskname = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your taskname'
                        )
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          task = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your task'
                        )
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Add Task!'),
                  onPressed: () async{
                    await addtask(taskname,task);
                    Navigator.pushNamed(context, 'TaskScreen');

                  },
                ),
                ElevatedButton(
                  child: Text('Show Tasks!'),
                  onPressed: () async{
                    Navigator.pushNamed(context, 'TaskScreen');

                  },
                ),
              ],
            ),
          )


      ),
    );
  }
  addtask(String taskname,String task) async{
    var Todo = todo();
    Todo.addTodo(taskname, task,"1");
  }
}
