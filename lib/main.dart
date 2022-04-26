import 'package:flutter/material.dart';
import 'package:flutter_keep/screens/about_screen.dart';
import 'package:flutter_keep/screens/edit_screen.dart';
import 'package:flutter_keep/screens/home_screen.dart';
import 'package:flutter_keep/screens/starter/starter_screen.dart';
import 'package:flutter_keep/src/models/contents_data.dart';
import 'package:provider/provider.dart';

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
      title: 'Flutter Keep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: StarterScreen.routeName,
      routes: {
        StarterScreen.routeName: (context) => const StarterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        EditScreen.routeName: (context) => const EditScreen(),
        AboutScreen.routeName: (context) => const AboutScreen(),
      },
    );
  }
}
