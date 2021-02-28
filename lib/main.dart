
/// This flutter project is Shopping mall management Application.
///            Group Members:
///                Hanan Kedir    ATE/9625/08
///               Meron Assefa   ATE/9448/08


import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Mall',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wraper(),
    );
  }
}
