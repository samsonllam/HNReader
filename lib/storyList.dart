import 'package:flutter/material.dart';

import './hn_manager.dart';

class StoryList extends StatelessWidget {
  final Future<List<Story>> storyList;

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
                  leading: const Icon(Icons.event_seat),
                  title: Text('${snapshot.data[index].title}'),
                  subtitle: Text(
                      '${snapshot.data[index].time}'),
                  onTap: () => print(snapshot.data[index].url),
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
