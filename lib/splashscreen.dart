import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieapp/home_page.dart';
import 'package:movieapp/login_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((val) {
      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 2, 56),
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
