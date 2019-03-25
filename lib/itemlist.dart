import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import './newspage.dart';

class HNReaderIcon {
  HNReaderIcon._();

  static const _kFontFam = 'HNReaderIcon';

  static const IconData github_circled = const IconData(0xf09b, fontFamily: _kFontFam);
  static const IconData stackoverflow = const IconData(0xf16c, fontFamily: _kFontFam);
}

Icon getIcon(String title, String url, String type) {
  if (url.contains('github.com')) {
    return const Icon(HNReaderIcon.github_circled);
  } else if (url.contains('youtube.com') || title.contains('[video]')) {
    return const Icon(Icons.ondemand_video);
  } else if (url.contains('stackoverflow.com')) {
    return const Icon(HNReaderIcon.stackoverflow);
  }else if (type == 'job') {
    return const Icon(Icons.work);
  } else if (type == 'ask') {
    return const Icon(Icons.record_voice_over);
  } else return const Icon(Icons.explore);
}

class Item {
  final String by;
  final int descendants;
  final String id;
  final List<dynamic> kids;
  final int score;
  final String text;
  final DateTime time;
  final String title;
  final String type;
  final String url;

  Item(
      {this.by,
      this.descendants,
      this.id,
      this.kids,
      this.score,
      this.text,
      this.time,
      this.title,
      this.type,
      this.url});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        by: json['by'],
        descendants: json['descendants'],
        id: json['id'].toString(),
        kids: json['kids'],
        score: json['score'],
        text: json['text'],
        time: DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000),
        title: json['title'],
        type: json['type'],
        url: json['url'] == null
            ? 'https://news.ycombinator.com/item?id=' + json['id'].toString()
            : json['url']);
  }
}

class ItemList extends StatefulWidget {
  ItemList();

  @override
  State<StatefulWidget> createState() {
    return _ItemListState();
  }
}

class _ItemListState extends State<ItemList> {
  final int _fetchItemCount = 10;
  int _lastIndexinItemList = 9;
  List<Item> _topItemList = new List();
  List<String> _topItemIdList = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();    
    fetchItemRange(0, 12);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _lastIndexinItemList += _fetchItemCount;
        fetchItemRange(_lastIndexinItemList - _fetchItemCount-1, _lastIndexinItemList);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  fetchItemId() async {
    http.Response response = await http.get(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');

    if (response.statusCode == 200) {
      List<String> topStoryList = response.body
          .substring(2, response.body.length - 2)
          .split(", ")
          .take(100)
          .toList();

      setState(() {
        _topItemIdList = topStoryList;
      });

    } else {
      throw Exception('Failed to load top stories');
    }
  }

  fetchItemRange(int from, int to) async {
    await fetchItemId();

    List<http.Response> list = await Future.wait(_topItemIdList
        .getRange(from, to)
        .map((id) => http.get('https://hacker-news.firebaseio.com/v0/item/' +
            id +
            '.json?print=pretty')));

    List<Item> topItemList = list.map((response) {
      return new Item.fromJson(jsonDecode(response.body));
    }).toList();

    topItemList.sort((a, b) => b.time.compareTo(a.time));

    setState(() {
      for (var item in topItemList) {
        _topItemList.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_topItemList.length > 0){
      return Expanded(
        child: new ListView.builder(
          controller: _scrollController,
          itemCount: _topItemList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: getIcon(
                  _topItemList[index].title.toString(),
                  _topItemList[index].url.toString(),
                  _topItemList[index].type.toString()),
              title: Text('${_topItemList[index].title}'),
              subtitle: Text(
                  '${new DateFormat('yyyy-MM-dd HH:MM').format(_topItemList[index].time)}'),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsWebPage(
                          '${_topItemList[index].title}',
                          '${_topItemList[index].url}'),
                    ),
                  ),
            );
          },
        ),
      );
    } else return Expanded(child: Center(child: CircularProgressIndicator()));
  }
}
