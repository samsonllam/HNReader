import 'package:flutter/material.dart';
import './newspage.dart';

import './hn_manager.dart';

class StoryList extends StatelessWidget {
  final Future<List<Item>> storyList;

  StoryList(this.storyList);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new FutureBuilder(
        future: storyList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // leading: const Icon(Icons.event_seat),
                  // leading: snapshot.data[index].url is String? new AssetImage('assets/github.png') : const Icon(Icons.event_seat),
                  // leading: snapshot.data[index].url is String? const Icon(Icons.access_alarm) : const Icon(Icons.event_seat),
                  leading: snapshot.data[index].type == 'job'? const Icon(Icons.work) : const Icon(Icons.explore),
                  title: Text('index: ${snapshot.data[index].title}'),
                  subtitle: Text(
                      '${snapshot.data[index].time}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsWebPage('${snapshot.data[index].title}', '${snapshot.data[index].url}')
                    )
                  )
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
