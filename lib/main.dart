import 'package:flutter/material.dart';
import 'package:movieapp/detail_page.dart';
import 'package:movieapp/home_page.dart';
import 'package:movieapp/profile_page.dart';
import 'package:movieapp/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Splashscreen(),
        '/home': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
