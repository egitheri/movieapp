import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/api_client.dart';

import 'shared_preference_manager.dart';
import 'widgets/movie_card_horizontal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<Map<String, dynamic>>> favoriteList;

  final _prefsManager = SharedPreferenceManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteList =
        ApiClient().fetchFavorite(_prefsManager.getSessionId().toString());
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        // elevation: 0,
        backgroundColor: Color(0xff022644),
      ),
      body: Container(
        color: Color(0xff022644),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.center,
            //   child: Container(
            //     width: 200,
            //     height: 200,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       image: DecorationImage(
            //         image: AssetImage(
            //           'assets/avatar.png',
            //         ),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Wrap(
                children: [
                  Text(
                    'My',
                    style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' Favorite',
                    style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        color: const Color(0xffffbe58),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 4.0, left: 16), // Space between text and line
              height: 2.0, // Thickness of the line
              width: 100.0, // Width of the line
              color: const Color(0xffffbe58), // Color of the line
            ),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: favoriteList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Movie not found'));
                  } else {
                    final favorite = snapshot.data!;

                    return Container(
                      padding: const EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2.4,
                      decoration: const BoxDecoration(
                          // color: Color(0xff022644),
                          ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics(),
                        itemCount: favorite.length,
                        itemBuilder: (context, index) {
                          final data = favorite[index];
                          return MovieCardHorizontal(
                            posterPath: data["poster_path"]!,
                            data: data,
                          );
                        },
                      ),
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Wrap(
                children: [
                  Text(
                    'My',
                    style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' Watchlist',
                    style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        color: const Color(0xffffbe58),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 4.0, left: 16), // Space between text and line
              height: 2.0, // Thickness of the line
              width: 100.0, // Width of the line
              color: const Color(0xffffbe58), // Color of the line
            ),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: favoriteList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Movie not found'));
                  } else {
                    final nowPlaying = snapshot.data!;

                    return Container(
                      padding: const EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2.4,
                      decoration: const BoxDecoration(
                          // color: Color(0xff022644),
                          ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics(),
                        itemCount: nowPlaying.length,
                        itemBuilder: (context, index) {
                          final data = nowPlaying[index];
                          return MovieCardHorizontal(
                            posterPath: data["poster_path"]!,
                            data: data,
                          );
                        },
                      ),
                    );
                  }
                }),
          ],
        )),
      ),
    );
  }
}
