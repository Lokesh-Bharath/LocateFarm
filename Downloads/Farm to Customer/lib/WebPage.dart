import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget{
  final String title;

  WebPage({Key key,this.title}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _WebPageState();
  }

}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar :new AppBar(
       title: new Text('WebView'),
     ),
     body : Builder(
       builder: (BuildContext context){
         return WebviewScaffold(
           url: 'http://183.82.5.184/rbzts/DailyPrices.aspx',
           withZoom: true,
           hidden: true,
           // javascriptMode: JavascriptMode.unrestricted,
         );
       },
     )
   );

  }

}