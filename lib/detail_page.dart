import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final baseUrl = 'https://image.tmdb.org/t/p/';
    final size = 'w500';
    final imageUrl = '$baseUrl$size${arguments['poster_path']}';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            color: Colors.black.withOpacity(0.6),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width / 2,
                    height: height / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    arguments['title'],
                    style: GoogleFonts.ubuntu(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 4.0, left: 16), // Space between text and line
                    height: 2.0, // Thickness of the line
                    width: 100.0, // Width of the line
                    color: const Color(0xffffbe58), // Color of the line
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    arguments['overview'],
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 0.4, color: Color(0xffffbe58))),
                    child: TextButton.icon(
                        onPressed: () {},
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle,
                              color: Color(0xffffbe58),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Play Trailer',
                              style: GoogleFonts.ubuntu(color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
