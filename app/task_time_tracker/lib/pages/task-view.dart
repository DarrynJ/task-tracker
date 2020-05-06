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
    String _title = "";
    String _description = "";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(110, 111, 190, 1),
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
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(hintText: "Title"),
                            autofocus: true,
                            onSaved: (value) => _title = value,
                            validator: (value) => value.length == 0
                                ? "A title must be supplied."
                                : null,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "Description"),
                            minLines: 3,
                            maxLines: 5,
                            onSaved: (value) => _description = value,
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
