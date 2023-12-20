
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todoflask/Model/todoitem.dart';

import 'package:todoflask/connection.dart';
import 'package:http/http.dart' as http;
class todo{

  Future<void> addTodo(String taskname,String task,String user_id) async {
    if (task.isEmpty || taskname.isEmpty) {
      return;
    }
    final url = 'http://192.168.93.158:8000/task';
    Map<String, dynamic> request = {"taskname": taskname, "task": task,"user_id": int.parse(user_id)};
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
        Uri.parse(url), headers: headers, body: json.encode(request));
    Map<String, dynamic> responsePayload = json.decode(response.body);
    final todo = TodoItem(
        id: responsePayload["id"],
        TaskName: responsePayload["taskname"],
        Task: responsePayload["task"],
    );
  }


   adduser(String Username,String Password) async {
    if (Username.isEmpty || Password.isEmpty) {
      return;
    }
    final url = 'http://192.168.93.158:8000/register';
    Map<String, dynamic> request = {"username": Username, "password": Password};
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
        Uri.parse(url), headers: headers, body: json.encode(request));
    Map<String, dynamic> responsePayload = json.decode(response.body);

    if(responsePayload["code"]==409)
      {
        print("username already exists try with diffrent username");
      }
    else{
    final user = User(
        id: responsePayload["id"],
        UserName: responsePayload["username"],
      );
     return user;
    }

  }

  gettodo(int user_id)async {
  final url= "http://192.168.93.158:8000/getuser/1";
  final response= await http.get(Uri.parse(url));
  print(response.body);
  Map<String, dynamic> responsePayload = json.decode(response.body);
  print(responsePayload);
  List tasks= responsePayload["tasks"];
  return tasks;

  }
 deletetodo(int task_id) async {
    final url= "http://192.168.93.158:8000/delete/${task_id}";
    final response= await http.delete(Uri.parse(url));
    Map<String, dynamic> responsePayload = json.decode(response.body);
    print(responsePayload["status"]);
 }

  Future<void> updatetodo(String taskname,String task,int task_id) async {
    if (task.isEmpty || taskname.isEmpty) {
      return;
    }
    final url = 'http://192.168.93.158:8000/update/$task_id';
    Map<String, dynamic> request = {"taskname": taskname, "task": task};
    final headers = {'Content-Type': 'application/json'};
    final response = await http.put(
        Uri.parse(url), headers: headers, body: json.encode(request));
    Map<String, dynamic> responsePayload = json.decode(response.body);
    final todo = TodoItem(
      id: responsePayload["id"],
      TaskName: responsePayload["taskname"],
      Task: responsePayload["task"],
    );
  }
}
