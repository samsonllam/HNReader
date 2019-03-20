import 'package:flutter/material.dart';
import './products.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  final _widgetOptions = [
    Text('Index 0: New Story'),
    Text('Index 1: Job'),
    Text('Index 2: Star'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          Products(['yo', 'hi']),
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), title: Text('New Story')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Job')),
          BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('Star')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}