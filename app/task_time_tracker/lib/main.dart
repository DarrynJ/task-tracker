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
      new List<String>.generate(30, (index) => "Task ${(index + 1)}");

  Widget _taskCard(String text) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.rectangle,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
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
          SliverList(
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Dismissible(
                  // dismissThresholds: Map(),
                  key: new ObjectKey(
                    _tempList[index],
                  ),
                  child: _taskCard(_tempList[index]),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      this._tempList.removeAt(index);
                    });
                    direction == DismissDirection.endToStart
                        ? print("stop")
                        : print("start");
                  },
                  background: new Container(
                    height: 100,
                    color: Color.fromRGBO(0, 96, 100, 0.8),
                    child: ListTile(
                      leading: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                  secondaryBackground: new Container(
                    height: 100,
                    color: Color.fromRGBO(183, 28, 28, 0.8),
                    child: ListTile(
                      trailing: Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                );
              },
              childCount: _tempList.length,
            ),
          )
        ],
      ),
    );
  }
}
