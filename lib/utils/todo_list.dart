import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TodolistWidget extends StatelessWidget {
  const TodolistWidget({super.key, required this.taskName, required this.taskCompleted, this.onChanged, this.deleteTask, this.updateTask});
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  final Function(BuildContext)? updateTask;

  @override
  Widget build(BuildContext context) {
     final mybox =  Hive.box("mybox");
    return Padding(
        padding: const EdgeInsets.only(top:20,bottom: 0,left: 20, right: 20),
        child:Slidable(
          endActionPane: ActionPane(
            motion: BehindMotion(),
            children: [
              SlidableAction(onPressed:updateTask,icon:Iconsax.edit_copy,backgroundColor: Colors.transparent,foregroundColor:const Color(0xFF00B0F5),),
               SlidableAction(onPressed:deleteTask,icon:Iconsax.trash_copy,backgroundColor: Colors.transparent,foregroundColor: const Color.fromARGB(255, 176, 36, 26),)
            ],
          ),
          child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width:0.6
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                     Checkbox(
                      
                      value: taskCompleted,
                      onChanged: onChanged,
                      checkColor:Colors.white,
                      activeColor:Colors.black,
                      side: const BorderSide(
                        color: Colors.black,
                        width:1
                      ),
                       shape: const CircleBorder(
                       ),
                      ),
                    Text(
                    taskName,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        decorationColor: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
        ),
        );
  }
}