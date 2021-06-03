import 'package:basicui/util/colors.dart';
import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: yellowSwatch,
        brightness: Brightness.light,
        fontFamily: 'Montserrat',
      ),
      home: HomeScreen(),
    );
  }
}
