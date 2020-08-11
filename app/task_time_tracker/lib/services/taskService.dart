import 'package:task_time_tracker/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//
//  This class handles everything to do with tasks.
//
class TaskService {
  Future<List<Task>> getTasks() async {
    List<Task> _tasks = new List<Task>();

    var documents = Firestore.instance.collection('tasks');
    documents.getDocuments().then((value) {
      value.documents.forEach((element) {
        _tasks.add(
            new Task(element['id'], element['name'], element['description']));
      });
    });

    return _tasks;
  }

  Task getTask(int taskId) => null;

  List<TaskEntry> getTaskEntries(int taskId) => null;

  void addTask(Task task) {}

  void updateTask(Task task) {}

  void deleteTask(int taskId) {}
}
