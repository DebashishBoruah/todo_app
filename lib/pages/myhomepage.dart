import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/utils/todo_list.dart';

class MyHomePage extends StatefulWidget {
 MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  List task = [
      ['Learn web developement', false],
      ['Learn DSA', false],
    ];

 void checkBoxChanged(int index)
 {
   setState(() {
     task[index][1] = !task[index][1];
   });
 }

 void saveTask()
 {
  setState(() {
    task.add([_controller.text, false]);
    _controller.clear();
  });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text("Todo App",style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
      itemCount:task.length,  
      itemBuilder:(context, index){
      return TodolistWidget(taskName: task[index][0],
      taskCompleted: task[index][1],
      onChanged: (value) => checkBoxChanged(index),
      );
      },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:30,right:10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Add new todo",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  fillColor: Colors.deepPurple.shade400,
                  filled: true
                ),
              ),
            ),
          ),
          FloatingActionButton(onPressed: (){
            saveTask();
          },child: const Icon(Icons.add),),
        ],
      ),
      );
  }
}