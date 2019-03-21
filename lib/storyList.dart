import 'package:flutter/material.dart';

class StoryList extends StatelessWidget {
  final Future<List<String>> storyList;

  StoryList(this.storyList);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storyList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data[0]);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: storyList,
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {

  //       if (snapshot.hasData) {
  //         return ListView.builder(
  //           itemCount: snapshot.data.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return ListTile(
  //               title: Text("dasd"),
  //             );
  //           }
  //         );
  //       } else if (snapshot.hasError) {
  //         return Text("${snapshot.error}");
  //       }
  //       // By default, show a loading spinner
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }
