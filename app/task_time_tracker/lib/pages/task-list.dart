import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_time_tracker/components/task-card.dart';
import 'package:task_time_tracker/services/taskService.dart';
import '../models/task.dart';

class TaskList extends StatefulWidget {
  @override
  TaskListState createState() => new TaskListState();
}

class TaskListState extends State<TaskList> {
  Timer _timer;
  List<Task> _tasks;

  Stopwatch _stopwatch = new Stopwatch();
  static const delay = Duration(seconds: 1);

  TaskService _service = new TaskService();

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  void _startTaskTimer(Task task) {
    _timer = Timer.periodic(delay, (Timer t) {
      setState(() {
        // TODO: start the task
      });
    });
  }

  void _stopTaskTimer(Task task) {
    _timer.cancel();
  }

  Future<Task> _showAddTaskDialog(BuildContext context) {
    final addTaskFormKey = new GlobalKey<FormState>();

    String _name = "", _description = "";

    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          title: Text("Add a new task"),
          contentPadding: EdgeInsets.all(10),
          children: <Widget>[
            Form(
              key: addTaskFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: "Name"),
                    autofocus: true,
                    onSaved: (value) => _name = value,
                    validator: (value) =>
                        value.length == 0 ? "A title must be supplied." : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Description"),
                    minLines: 3,
                    maxLines: 5,
                    onSaved: (value) => _description = value,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          },
                          child: Text("Cancel"),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            if (addTaskFormKey.currentState.validate()) {
                              addTaskFormKey.currentState.save();
                              Navigator.of(context)
                                  .pop(); // TODO: add task here.
                            }
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
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
    _service.getTasks().then((value) => _tasks = value);

    return Scaffold(
      body: CustomScrollView(
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
              key: new ObjectKey(_tasks), // TODO: should be the tasks
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return new Dismissible(
                    direction: DismissDirection.endToStart,
                    key: new ObjectKey(
                      _tasks[index], // TODO: should be the task at the index
                    ),
                    child: TaskCard(
                        _tasks[index]), // TODO: should be the task at the index
                    confirmDismiss: (DismissDirection direction) {
                      return _showDeleteConfirmation(context).then((delete) {
                        if (delete) {
                          setState(() {
                            // TODO: stop the task time and remove the task at the current index
                          });

                          SnackBar deleteSnackBar = SnackBar(
                            duration: Duration(seconds: 1),
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
                childCount: 1, 
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTaskDialog(context).then((task) {
            if (task != null) {
              setState(() {
                // TODO: add the new task to the list
              });

              SnackBar infoSnackBar = SnackBar(
                duration: Duration(seconds: 1),
                content: Text("New task added."),
              );
              Scaffold.of(context).showSnackBar(infoSnackBar);
            }
          });
        },
      ),
    );
  }
}
