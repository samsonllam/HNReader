import 'package:flutter/material.dart';

class StoryList extends StatelessWidget {
  final Future<List<String>> storyList;

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
                return Card(
                  child: new Text('${snapshot.data[index]}'),
                );
              },
            );
            // return Text(snapshot.data[4] + " " + (snapshot.data.length is int).toString());
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
