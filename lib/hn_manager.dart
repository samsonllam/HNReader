import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './storyList.dart';

Future<List<String>> fetchTopNewsId() async {
  http.Response response = await http.get('https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty'); 

  List<String> topStoryList = response.body.substring(2, response.body.length-2).split(", ").take(30).toList();

  if (response.statusCode == 200) {
    return topStoryList;
  } else {
    throw Exception('Failed to load top stories');
  }
}

Future<List<Story>> fetchNewsStory() async {
  List<String> topNewsId = await fetchTopNewsId();
  List<http.Response> list = await Future.wait(topNewsId.map((id) => http.get('https://hacker-news.firebaseio.com/v0/item/' + id + '.json?print=pretty')));

  return list.map((response){
    return new Story.fromJson(jsonDecode(response.body));
  }).toList();
}

class Story {
  final String by;
  final int descendants;
  final String id;
  final List<dynamic> kids;
  final int score;
  final DateTime time;
  final String title;
  final String type;
  final String url;

  Story({this.by, this.descendants, this.id, this.kids, this.score, this.time, this.title, this.type, this.url});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      by: json['by'],
      descendants: json['descendants'],
      id: json['id'].toString(),
      kids: json['kids'],
      score: json['score'],
      time: DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000),
      title: json['title'],
      type: json['type'],
      url: json['url']
    );
  }
}

class HNManager extends StatefulWidget {

  HNManager();

  @override
  State<StatefulWidget> createState() {
    return _HNManagerState();
  }
}

class _HNManagerState extends State<HNManager> {
  @override
  Widget build(BuildContext context) {
    return StoryList(fetchNewsStory());
    
  }
}