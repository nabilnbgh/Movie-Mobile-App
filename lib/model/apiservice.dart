import 'package:dio/dio.dart';
import 'package:movie_application/model/anime.dart';

class APIService {
  String url = 'http://192.168.100.3:3000/';
  final Dio dio = Dio();

  Future<List<Anime>> getPopularAnime(CancelToken cancelToken) async {
    final Uri uri = Uri.parse(url).replace(path: 'popular', queryParameters: {
      'page': '1',
    });
    try {
      final response = await dio.getUri(uri, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        List jsontoList = response.data as List;
        List<Anime> listAnime =
            List<Anime>.from(jsontoList.map((e) => Anime.fromJson(e)));
        return listAnime;
      } else {
        throw Exception('Failed to load popular anime');
      }
    } catch (e) {
      print("popular anime");
      rethrow;
    }
  }

  Future<List<Anime>> getTopAiringAnime(CancelToken cancelToken) async {
    final Uri uri =
        Uri.parse(url).replace(path: 'top-airing', queryParameters: {
      'page': '1',
    });
    try {
      final response = await dio.getUri(uri, cancelToken: cancelToken);

      if (response.statusCode == 200) {
        List jsontoList = response.data as List;
        List<Anime> listAnime =
            List<Anime>.from(jsontoList.map((e) => Anime.fromJson(e)));
        return listAnime;
      } else {
        throw Exception('Failed to load top airing anime');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Anime>> getAnimeMovies(CancelToken cancelToken) async {
    final Uri uri =
        Uri.parse(url).replace(path: 'anime-movies', queryParameters: {
      'page': '1',
    });
    try {
      final response = await dio.getUri(uri, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        List jsontoList = response.data as List;
        List<Anime> listAnime =
            List<Anime>.from(jsontoList.map((e) => Anime.fromJson(e)));
        return listAnime;
      } else {
        throw Exception('Failed to load anime movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Anime>> getSearchAnime(
      String keyword, CancelToken cancelToken) async {
    final Uri uri = Uri.parse(url).replace(path: 'search', queryParameters: {
      'keyw': keyword,
      'page': '1',
    });
    try {
      final response = await dio.getUri(uri, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        List jsontoList = response.data as List;
        List<Anime> listAnime =
            List<Anime>.from(jsontoList.map((e) => Anime.fromJson(e)));
        return listAnime;
      } else {
        throw Exception('Failed to load anime movies');
      }
    } catch (e) {
      rethrow;
    }
  }
}
