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
    final updateTaskFormKey = new GlobalKey<FormState>();
    String _name = "";
    String _description = "";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          children: <Widget>[
            // Overview of task entries over the month
            SafeArea(
              child: Container(
                height: 275,
                margin: EdgeInsets.only(
                  bottom: 10,
                  left: 15,
                  right: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius:
                          10.0, // has the effect of softening the shadow
                      spreadRadius:
                          0.0, // has the effect of extending the shadow
                      offset: Offset(
                        0.0, // horizontal, move right 10
                        1.5, // vertical, move down 10
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 25,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius:
                          10.0, // has the effect of softening the shadow
                      spreadRadius:
                          0.0, // has the effect of extending the shadow
                      offset: Offset(
                        0.0, // horizontal, move right 10
                        1.5, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Form(
                    key: updateTaskFormKey,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(hintText: "Name"),
                            initialValue: task.name,
                            onSaved: (value) => _name = value,
                            validator: (value) => value.length == 0
                                ? "A title must be supplied."
                                : null,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "Description"),
                            minLines: 3,
                            maxLines: 5,
                            initialValue: task.description,
                            onSaved: (value) => _description = value,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                              child: Text(
                                "", // TOOD: add a friendly display of time captured today
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      _name = task.name;
                                      _description = task.description;
                                    });
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
                                    if (updateTaskFormKey.currentState
                                        .validate()) {
                                      updateTaskFormKey.currentState.save();

                                      setState(() {
                                        task.name = _name;
                                        task.description = _description;
                                      });
                                    }
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
