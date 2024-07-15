import 'package:flutter/material.dart';

class TodolistWidget extends StatelessWidget {
  const TodolistWidget({super.key, required this.taskName, required this.taskCompleted, this.onChanged});
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top:20,bottom: 0,left: 20, right: 20),
        child:Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                   Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    checkColor:Colors.white,
                    activeColor:Colors.black,
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    ),
                  Text(
                  taskName,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      decorationColor: Colors.white
                    ),
                  ),
                ],
              ),
            ),
        );
  }
}