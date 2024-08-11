import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/api_client.dart';

import '../shared_preference_manager.dart';

class MovieCardHorizontal extends StatefulWidget {
  String posterPath;
  Map<String, dynamic> data;
  MovieCardHorizontal(
      {super.key, required this.posterPath, required this.data});

  @override
  State<MovieCardHorizontal> createState() => _MovieCardHorizontalState();
}

class _MovieCardHorizontalState extends State<MovieCardHorizontal> {
  late bool isShowOverlay = false;
  late bool isFavorite = false;
  late bool isWatchlist = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.movieId);
  }

  void favorite() {}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.width;
    final double cardWidth = screenHeight / 4;
    final double cardHeight = cardWidth / 0.6;

    final baseUrl = 'https://image.tmdb.org/t/p/';
    final size = 'w500';
    final imageUrl = '$baseUrl$size${widget.posterPath}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isShowOverlay = true;
                });
              },
              child: Container(
                width: cardWidth,
                height: cardHeight,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage("$imageUrl"), fit: BoxFit.cover)),
              ),
            ),
            isShowOverlay ? overlayMovie(context) : Container()
          ],
        ),
      ],
    );
  }

  Widget overlayMovie(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.width;
    final double cardWidth = screenHeight / 4;
    final double cardHeight = cardWidth / 0.6;

    final _prefsManager = SharedPreferenceManager();

    return InkWell(
      onTap: () {
        setState(() {
          isShowOverlay = false;
        });
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        color: Colors.black.withOpacity(0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      var sessionId = _prefsManager.getSessionId();

                      setState(() {
                        isFavorite = !isFavorite;
                      });

                      if (isFavorite) {
                        ApiClient().addFavorite(
                            int.parse(widget.data['id'].toString()),
                            sessionId.toString());
                      } else {
                        ApiClient().removeFavorite(
                            int.parse(widget.data['id'].toString()),
                            sessionId.toString());
                      }
                    },
                    color: isFavorite ? Colors.red : Colors.white,
                    icon: isFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border)),
                IconButton(
                    onPressed: () {
                      var sessionId = _prefsManager.getSessionId();
                      setState(() {
                        isWatchlist = !isWatchlist;
                      });

                      if (isFavorite) {
                        ApiClient().addFavorite(
                            int.parse(widget.data['id'].toString()),
                            sessionId.toString());
                      } else {
                        ApiClient().removeFavorite(
                            int.parse(widget.data['id'].toString()),
                            sessionId.toString());
                      }
                    },
                    color: Colors.white,
                    icon: isWatchlist
                        ? Icon(Icons.bookmark)
                        : Icon(Icons.bookmark_border)),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detail', arguments: widget.data);
              },
              child: Text(
                'Show',
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(),
            )
          ],
        ),
      ),
    );
  }
}
