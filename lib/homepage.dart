import 'package:flutter/material.dart';
import './itemlist.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HNReader',
      home: _MyTabBar(),
    );
  }
}

class _MyTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.list), text: 'Top Stories'),
            Tab(icon: Icon(Icons.rss_feed), text: 'Top Stories'),
          ],
          unselectedLabelColor: Color(0xff999999),
          labelColor: Colors.deepPurple,
          indicatorColor: Colors.transparent,
        ),
        body: TabBarView(
          children: [
            Column(children: [ItemList()],),
            Center( child: Text('page2'),),
          ]
        )
      )
    );
  }

}