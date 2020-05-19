import 'package:flutter/material.dart';
import './pages/task-list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        backgroundColor: const Color(0xff2c2c2c),
        scaffoldBackgroundColor: const Color(0xff2c2c2c),
      ),
      routes: {
        '/Home': (context) => Home(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskList(),
    );
  }
}
