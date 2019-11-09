import 'package:flutter/material.dart';

import 'MyHomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSH Tool',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto'
      ),
      home: MyHomePage(),
    );
  }
}
