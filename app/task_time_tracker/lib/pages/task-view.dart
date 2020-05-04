import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskView extends StatefulWidget {
  final Task incomingTask;

  TaskView(this.incomingTask);

  @override
  _TaskViewState createState() => new _TaskViewState(this.incomingTask);
}

class _TaskViewState extends State<TaskView> {
  Task task;

  _TaskViewState(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.task.name),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.person_outline),
                tooltip: 'Profile',
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
