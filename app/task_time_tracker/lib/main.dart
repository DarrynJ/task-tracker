import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<String> _tempList =
      new List<String>.generate(30, (index) => "Task ${index}");

  Widget _taskCard(String text) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Text(
          text,
        ),
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
                title: Text('Time tracked'),
              ),
              actionsIconTheme: IconThemeData(
                size: double.infinity,
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
          SliverList(
            delegate: SliverChildListDelegate(
              _tempList.map((item) {
                return _taskCard(item);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
