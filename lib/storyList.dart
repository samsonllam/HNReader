import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import './hn_manager.dart';
import './newspage.dart';


class GithubIcon {
  GithubIcon._();

  static const _kFontFam = 'GithubIcon';

  static const IconData star = const IconData(0xe800, fontFamily: _kFontFam);
  static const IconData github_circled = const IconData(0xf09b, fontFamily: _kFontFam);
  static const IconData github = const IconData(0xf113, fontFamily: _kFontFam);
  static const IconData github_squared = const IconData(0xf300, fontFamily: _kFontFam);
}


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
                    leading: snapshot.data[index].url.toString().contains('github.com')
                        ? const Icon(GithubIcon.github)
                        : snapshot.data[index].type == 'job'
                            ? const Icon(Icons.work)
                            : snapshot.data[index].type == 'ask'
                                ? const Icon(Icons.record_voice_over)
                                : const Icon(Icons.explore),
                    title: Text('${snapshot.data[index].title}'),
                    subtitle: Text(
                        '${new DateFormat('yyyy-MM-dd HH:MM').format(snapshot.data[index].time)}'),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsWebPage(
                                '${snapshot.data[index].title}',
                                '${snapshot.data[index].url}'))));
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
