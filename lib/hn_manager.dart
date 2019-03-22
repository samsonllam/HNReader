import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './storyList.dart';

Future<List<String>> fetchTopNewsId() async {
  http.Response response = await http.get('https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty'); 

  List<String> topStoryList = response.body.substring(2, response.body.length-2).split(", ").take(20).toList();

  if (response.statusCode == 200) {
    return topStoryList;
  } else {
    throw Exception('Failed to load top stories');
  }
}

Future<List<String>> fetchNewsStory() async {
  List<String> topNewsId = await fetchTopNewsId();
  List<String> topNewsStory;


  for (var id in topNewsId) {
  http.Response response = await http.get('https://hacker-news.firebaseio.com/v0/item/' + id + '.json?print=pretty'); 
    topNewsStory.add(response.body);
  }

  return topNewsStory;
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