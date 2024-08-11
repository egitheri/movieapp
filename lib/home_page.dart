import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/api_client.dart';
import 'package:movieapp/widgets/movie_card_horizontal.dart';

import 'shared_preference_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> fetchCarousel = [
    'https://media.themoviedb.org/t/p/w440_and_h660_face/aojc4ThuOvH4UzQAhyLFoJxYUz3.jpg',
    'https://media.themoviedb.org/t/p/w440_and_h660_face/oGythE98MYleE6mZlGs5oBGkux1.jpg',
    'https://media.themoviedb.org/t/p/w440_and_h660_face/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg'
  ];

  late Future<List<Map<String, dynamic>>> nowPlayingList;
  late Future<List<Map<String, dynamic>>> populerList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowPlayingList = ApiClient().fetchNowPlaying();
    populerList = ApiClient().fetchPopuler();
    _fetchCarouselImages();
  }

  Future<void> _fetchCarouselImages() async {
    // Here, you would typically make an API call to get the carousel images.
    // For example:
    List<String> fetchedImages = await ApiClient().fetchCarousel();

    // Update the state with the new list of images.
    setState(() {
      fetchCarousel = fetchedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xff022644),
      body: Stack(
        children: [
          Builder(builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            final double width = MediaQuery.of(context).size.width;
            return CarouselSlider(
                items: fetchCarousel
                    .map((item) => Container(
                          child: Center(
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              height: height,
                              width: width,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: height,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                ));
          }),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff022644).withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(12))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Wrap(
                        children: [
                          Text(
                            'Now',
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' Playing',
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
                        future: nowPlayingList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Wrap(
                        children: [
                          Text(
                            'What\'s',
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' Popular',
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
                        future: populerList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
