import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:movie_application/model/anime.dart';
import 'package:movie_application/model/animedetail.dart';
import 'package:movie_application/model/recentepisode.dart';
import 'package:movie_application/model/vidcdn.dart';

class APIService {
  String url = 'http://192.168.100.3:3000/';
  final Dio dio = Dio();

  Future<List<RecentEpisode>> getRecentEpisode(CancelToken cancelToken) async {
    final Uri uri =
        Uri.parse(url).replace(path: 'recent-release', queryParameters: {
      'page': '1',
    });
    try {
      final response = await dio.getUri(uri, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        List json = response.data;
        List<RecentEpisode> listRecentEpisode = List<RecentEpisode>.from(
            json.map((e) => RecentEpisode.fromJson(e)));
        return listRecentEpisode;
      } else {
        throw Exception('Failed to load recent episodes');
      }
    } catch (e) {
      rethrow;
    }
  }

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

  Future<AnimeDetail?> getDetailAnime(
      String animeId, CancelToken cancelToken) async {
    final Uri uri = Uri.parse(url).replace(path: 'anime-details/$animeId');
    try {
      final response = await dio.getUri(uri, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = response.data;
        AnimeDetail data = AnimeDetail.fromJson(json);
        return data;
        // return data;
      } else {
        throw Exception('Failed to load detailed anime');
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<VidCDN> getStreamingURL(
      String animeId, CancelToken cancelToken) async {
    // dio.options.headers['Referer'] = 'https://gogoplay.io/';
    final Uri uri = Uri.parse(url).replace(path: 'vidcdn/watch/$animeId');
    try {
      final response = await dio.getUri(uri, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = response.data;
        VidCDN data = VidCDN.fromJson(json);
        return data;
        // return data;
      } else {
        throw Exception('Failed to load detailed anime');
      }
    } catch (e) {
      rethrow;
    }
  }
}
