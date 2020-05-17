import 'dart:async';

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../pages/task-view.dart';

class TaskList extends StatefulWidget {
  @override
  TaskListState createState() => new TaskListState();
}

class TaskListState extends State<TaskList> {
  Timer _timer;

  Stopwatch _stopwatch = new Stopwatch();
  static const delay = Duration(seconds: 1);

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

  Widget _taskCard(Task task) {
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
          _actionContainer(task),
          Expanded(
            child: _descriptionContainer(task),
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

  @override
  Widget build(BuildContext context) {
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
              key: new ObjectKey(null), // TODO: should be the tasks
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return new Dismissible(
                    direction: DismissDirection.endToStart,
                    key: new ObjectKey(
                      null, // TODO: should be the task at the index
                    ),
                    child: _taskCard(null), // TODO: should be the task at the index
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
                childCount: 0, // TODO: should be the tasks length
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