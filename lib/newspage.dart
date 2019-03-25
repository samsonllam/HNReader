import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsWebPage extends StatelessWidget {
  final String title;
  final String url;

  NewsWebPage(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
              url: url,
              appBar: new AppBar(
                title: new Text(title),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              withJavascript: true,
              scrollBar: true,
            ),
      },
      theme: Theme.of(context),
    );
  }
}
