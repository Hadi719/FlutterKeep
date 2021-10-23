import 'package:flutter/material.dart';
import 'package:flutter_note/screens/edit_screen.dart';
import 'package:provider/provider.dart';

import '../models/contents_data.dart';
import '../screens/home_screen.dart';
import '../screens/starter/starter_screen.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<ContentsData>(
      create: (_) => ContentsData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        primaryColor: Colors.blueAccent,
      ),
      initialRoute: StarterScreen.routeId,
      routes: {
        StarterScreen.routeId: (context) => const StarterScreen(),
        HomeScreen.routeId: (context) => const HomeScreen(),
        EditScreen.routeId: (context) => const EditScreen(),
      },
    );
  }
}
