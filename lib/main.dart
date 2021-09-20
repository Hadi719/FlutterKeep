import 'package:flutter/material.dart';

import 'screens/starter/starter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        primaryColor: Colors.blueAccent,
      ),
      home: const StarterScreen(),
    );
  }
}
