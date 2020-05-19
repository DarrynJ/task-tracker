class Task {
  int id;
  String name;
  String description;
}

class TaskEntry {
  int taskId;
  bool started;
  int seconds;
  DateTime captured;

  String toDurationDisplay() => new Duration(seconds: this.seconds)
      .toString()
      .split('.')
      .first
      .padLeft(8, "0");
}
