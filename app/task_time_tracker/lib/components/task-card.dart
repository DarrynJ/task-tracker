import 'package:flutter/material.dart';
import 'package:task_time_tracker/models/task.dart';
import '../pages/task-view.dart';

class TaskCard extends StatefulWidget {
  final Task _task;

  TaskCard(this._task);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.rectangle,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.1,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _actionContainer(widget._task),
          Expanded(
            child: _descriptionContainer(widget._task),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              "", // TODO: a task friendly display date.
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskIcon(IconData icon) {
    return Icon(icon, color: Colors.black, size: 50);
  }

  Widget _actionContainer(Task task) {
    return InkWell(
      child: Container(
        width: 100,
        height: 100,
        child: false // TODO: add check on task entry
            ? _taskIcon(Icons.stop)
            : _taskIcon(Icons.play_arrow),
      ),
      onTap: () {
        setState(() {
          // TODO: Stop all tasks, save their captured time and start the next task
        });
      },
    );
  }

  Widget _descriptionContainer(Task task) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        task.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        task.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskView(task),
            ));
      },
      onLongPress: () {},
    );
  }
}
