import 'package:flutter/material.dart';

import 'screen/home_screen.dart';
import 'util/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bankard',
      debugShowCheckedModeBanner: false,
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
