import 'package:flutter/material.dart';
import './models/task.dart';
import './pages/task-view.dart';

class TaskList extends StatefulWidget {
  @override
  TaskListState createState() => new TaskListState();
}

class TaskListState extends State<TaskList> {
  List<Task> _taskList = new List<Task>.generate(
      30,
      (index) => new Task((index + 1), "Task ${(index + 1)}",
          "Description for task ${(index + 1)}", false));

  Widget _taskStartIcon() {
    return Icon(
      Icons.play_arrow,
      color: Colors.black,
      size: 50,
    );
  }

  Widget _taskStopIcon() {
    return Icon(
      Icons.stop,
      color: Colors.black,
      size: 50,
    );
  }

  Widget _actionContainer(Task task) {
    return InkWell(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.1,
            ),
          ),
        ),
        child: task.taskStarted ? _taskStopIcon() : _taskStartIcon(),
      ),
      onTap: () {
        setState(() {
          _taskList.forEach((e) {
            if (e.id != task.id) {
              e.taskStarted = false;
            }
          });

          task.taskStarted = !task.taskStarted;
        });
      },
    );
  }

  Widget _descriptionContainer(Task task) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.1,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      task.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
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
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
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

  Widget _taskCard(Task task) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.rectangle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _actionContainer(task),
          Expanded(
            child: _descriptionContainer(task),
          ),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete task"),
            content: Text("Are you sure you wish to delete task?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              RaisedButton(
                  color: Color.fromRGBO(183, 28, 28, 0.8),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('TODO: Add text here'),
            ),
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Search',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline),
                    tooltip: 'Profile',
                    onPressed: () {},
                  ),
                ],
              )
            ]),
        Container(
          child: SliverList(
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Dismissible(
                  direction: DismissDirection.endToStart,
                  key: new ObjectKey(
                    _taskList[index],
                  ),
                  child: _taskCard(_taskList[index]),
                  confirmDismiss: (DismissDirection direction) {
                    return _showDeleteConfirmation(context).then((delete) {
                      if (delete) {
                        _taskList.removeAt(index);

                        SnackBar deleteSnackBar = SnackBar(
                          content: Text("Task successfully removed."),
                        );
                        Scaffold.of(context).showSnackBar(deleteSnackBar);
                      }
                      return delete;
                    });
                  },
                  background: new Container(),
                  secondaryBackground: new Container(
                    height: 100,
                    color: Color.fromRGBO(183, 28, 28, 0.8),
                    child: Center(
                      child: ListTile(
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: _taskList.length,
            ),
          ),
        ),
      ],
    );
  }
}
