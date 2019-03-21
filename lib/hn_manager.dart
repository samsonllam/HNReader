import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './storyList.dart';

Future<List<String>> fetchTopNews() async {
  http.Response response = await http.get('https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty'); 

  List<String> topStoryList = response.body.substring(1, response.body.length-2).split(", ");

  if (response.statusCode == 200) {
    return topStoryList;
  } else {
    throw Exception('Failed to load top stories');
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
    return StoryList(fetchTopNews());
  }
}