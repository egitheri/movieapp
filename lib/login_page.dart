import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/home_page.dart';
import 'package:movieapp/shared_preference_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();

  final _prefsManager = SharedPreferenceManager();

  void loginPress() async {
    final url = 'https://api.themoviedb.org/3/authentication/guest_session/new';
    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWMxYTA5NTllNWJiZmFhZjJmMjcwNTczNmVmM2YwOCIsIm5iZiI6MTcyMzIzMTY3My43NzYwODYsInN1YiI6IjY2YjBjZGY2NTE2ODZlODMzMzBjZGU1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xYkRb9MhpmoYNcQWchSfGEKoy8z-FvkGw4K5CB2LR6E',
    };

    try {
      final response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        _prefsManager.saveSessionId('${data["guest_session_id"]}');

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    'https://media.themoviedb.org/t/p/w440_and_h660_face/oGythE98MYleE6mZlGs5oBGkux1.jpg'),
                fit: BoxFit.cover,
              )),
            ),
            Container(
              width: width,
              height: height,
              color: Colors.black.withOpacity(0.6),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    // color: Color(0xffffbe58),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xffffbe58),
                    )),
                child: TextButton(
                  onPressed: () => loginPress(),
                  child: Text(
                    'Authenticate with TMDB',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
