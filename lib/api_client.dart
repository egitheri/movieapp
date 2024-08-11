import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  List<String> carouselImageList = [];

  String authToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWMxYTA5NTllNWJiZmFhZjJmMjcwNTczNmVmM2YwOCIsIm5iZiI6MTcyMzIzMTY3My43NzYwODYsInN1YiI6IjY2YjBjZGY2NTE2ODZlODMzMzBjZGU1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xYkRb9MhpmoYNcQWchSfGEKoy8z-FvkGw4K5CB2LR6E";

  Future<List<String>> fetchCarousel() async {
    final dio = Dio();
    final url = 'https://api.themoviedb.org/3/movie/now_playing';
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    try {
      final response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        List<dynamic> results = response.data['results'];
        List<String> imgList = results.map((movie) {
          return 'https://media.themoviedb.org/t/p/w440_and_h660_face${movie['poster_path']}';
        }).toList();

        return imgList;
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      throw Exception('Error fetching now playing movies: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPopuler() async {
    final dio = Dio();
    final url = 'https://api.themoviedb.org/3/movie/popular';
    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWMxYTA5NTllNWJiZmFhZjJmMjcwNTczNmVmM2YwOCIsIm5iZiI6MTcyMzIzMTY3My43NzYwODYsInN1YiI6IjY2YjBjZGY2NTE2ODZlODMzMzBjZGU1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xYkRb9MhpmoYNcQWchSfGEKoy8z-FvkGw4K5CB2LR6E',
    };
    try {
      final response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['results']);
      } else {
        throw Exception('Failed to load populer movies');
      }
    } catch (e) {
      throw Exception('Error fetching populer movies: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchNowPlaying() async {
    final dio = Dio();
    final url = 'https://api.themoviedb.org/3/movie/now_playing';
    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWMxYTA5NTllNWJiZmFhZjJmMjcwNTczNmVmM2YwOCIsIm5iZiI6MTcyMzIzMTY3My43NzYwODYsInN1YiI6IjY2YjBjZGY2NTE2ODZlODMzMzBjZGU1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xYkRb9MhpmoYNcQWchSfGEKoy8z-FvkGw4K5CB2LR6E',
    };
    try {
      final response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['results']);
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      throw Exception('Error fetching now playing movies: $e');
    }
  }

  Future<void> addFavorite(int movieId, String sessionId) async {
    final response = await _dio.post(
      'https://api.themoviedb.org/3/account/{account_id}/favorite',
      data: {
        'media_type': 'movie',
        'media_id': movieId,
        'favorite': true,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add favorite');
    }
  }

  Future<void> removeFavorite(int movieId, String sessionId) async {
    final response = await _dio.post(
      'https://api.themoviedb.org/3/account/{account_id}/favorite',
      data: {
        'media_type': 'movie',
        'media_id': movieId,
        'favorite': false,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to remove favorite');
    }
  }

  Future<void> addWatchlist(int movieId, String sessionId) async {
    final response = await _dio.post(
      'https://api.themoviedb.org/3/account/{account_id}/watchlist',
      data: {
        'media_type': 'movie',
        'media_id': movieId,
        'watchlist': true,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add watchlist');
    }
  }

  Future<void> removeWatchlist(int movieId, String sessionId) async {
    final response = await _dio.post(
      'https://api.themoviedb.org/3/account/{account_id}/watchlist',
      data: {
        'media_type': 'movie',
        'media_id': movieId,
        'watchlist': false,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to remove watchlist');
    }
  }

  Future<List<Map<String, dynamic>>> fetchFavorite(String sessionId) async {
    // try {
    final response = await _dio.post(
      'https://api.themoviedb.org/3/account/21424581/favorite/movie?language=en-US&page=1&sort_by=created_at.asc',
      // data: {'language': 'en-US', 'page': 1, 'session_id': sessionId},
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data['results']);
    } else {
      throw Exception('Failed to load now playing movies');
    }
    // } catch (e) {
    //   throw Exception('Error fetching now playing movies: $e');
    // }
  }
}
