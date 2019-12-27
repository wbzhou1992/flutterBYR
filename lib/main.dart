import 'package:flutter/material.dart';
import 'package:flutterdemo/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: HomePage());
  }
}
