import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:todoapp/database/todotask_database.dart';
import 'package:todoapp/utils/todo_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final _updatecontroller = TextEditingController();
  final Box mybox = Hive.box("mybox");
  final TodotaskDatabase _db = TodotaskDatabase();

  @override
  void initState() {
    super.initState();
    if (mybox.get('TODOLIST') == null) {
      _db.createInitialData();
    } else {
      _db.loadData();
    }
  }

  void checkBoxChanged(int index) {
    setState(() {
      _db.task[index][1] = !_db.task[index][1];
    });
    _db.updateData();
  }

  void saveTask() {
    if (_controller.text.isEmpty) {
      const message = SnackBar(
        duration: Duration(seconds: 1),
        content: Text("Add a task first"),
        backgroundColor: Colors.black,
      );
      ScaffoldMessenger.of(context).showSnackBar(message);
    } else {
      setState(() {
        _db.task.add([_controller.text, false]);
        _controller.clear();
      });
      _db.updateData();
    }
  }

  void deleteTaskFunction(int index) {
    setState(() {
      _db.task.removeAt(index);
    });
    _db.updateData();
  }

void updateTask(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Update your task",style: TextStyle(fontSize:17,fontWeight:FontWeight.w500),),
        content:Container(
          width:280,
          height:130,
          child: Column(
            children: [
              TextField(
                controller: _updatecontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
             const SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
           ElevatedButton(
  style: ElevatedButton.styleFrom(
    side:const BorderSide(color: Colors.transparent),
    
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: (){
    deleteTaskFunction(index) ;
    setState(() {
        _db.task.add([_updatecontroller.text, false]);
        _updatecontroller.clear();
      });
      _db.updateData();
     Navigator.of(context).pop();
  },
  child: const Text("Update"),
),

OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: () {
    Navigator.of(context).pop();
  },
  child: const Text("Cancel"),
),

                ],
              )
            ],
          ),
        ),
      );
    },
  );

  // Add your task update logic here
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Iconsax.color_swatch),
            Text(
              "Todo App",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00B0F5),
        foregroundColor: Colors.white,
      ),
      body: _db.task.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  Icon(
                    Iconsax.task_square,
                    size: 100,
                    color: Colors.grey.shade400,
                  ), 
                  const SizedBox(height: 10),
                    const Text(
                    "No tasks available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                
                ],
              ),
            )
          : ListView.builder(
              itemCount: _db.task.length,
              itemBuilder: (context, index) {
                return TodolistWidget(
                  taskName: _db.task[index][0],
                  taskCompleted: _db.task[index][1],
                  onChanged: (value) => checkBoxChanged(index),
                  deleteTask: (context) => deleteTaskFunction(index),
                  updateTask: (context) =>  updateTask(context, index),
                );
              },
            ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Add new todo",
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              saveTask();
            },
            child: const Icon(
              Iconsax.additem,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
