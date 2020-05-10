class Task {
  int id;
  String name;
  String description;
  bool taskStarted = false;
  int seconds = 0;

  Task(this.id, this.name, this.description, this.taskStarted);

  Duration getDuration() {
    return new Duration(seconds: this.seconds);
  }

  String toCapturedDisplayTime() {
    Duration capturedDuration = this.getDuration();

    if (capturedDuration.inHours > 0)
      return "${capturedDuration.inHours.toString()} hrs";
    else if (capturedDuration.inMinutes > 0)
      return "${capturedDuration.inMinutes.toString()} min";
    else if (capturedDuration.inSeconds > 0)
      return "${capturedDuration.inSeconds.toString()} sec";
    else
      return "";
  }

  String format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
}
