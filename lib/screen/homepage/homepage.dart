import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/model/anime.dart';
import 'package:movie_application/service/apiservice.dart';
import 'package:movie_application/model/recentepisode.dart';
import 'package:movie_application/shared/moviecard.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  APIService apiService = APIService();
  final popularCancelToken = CancelToken();
  final topAiringCancelToken = CancelToken();
  final animeMoviesCancelToken = CancelToken();
  final recentEpisodeCancelToken = CancelToken();
  List<Anime> listPopularAnime = [];
  List<Anime> listTopAiringAnime = [];
  List<Anime> listAnimeMovies = [];
  List<RecentEpisode> listRecentEpisodes = [];

  bool isLoading = true;
  // get all data from backend
  void getData() async {
    try {
      listPopularAnime = await apiService.getPopularAnime(popularCancelToken);
      listTopAiringAnime =
          await apiService.getTopAiringAnime(topAiringCancelToken);
      listAnimeMovies = await apiService.getAnimeMovies(animeMoviesCancelToken);
      listRecentEpisodes =
          await apiService.getRecentEpisode(recentEpisodeCancelToken);
      if (!popularCancelToken.isCancelled &&
          !topAiringCancelToken.isCancelled &&
          !animeMoviesCancelToken.isCancelled &&
          !recentEpisodeCancelToken.isCancelled) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      developer.log('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: const Text(
              "Recently Updated Anime",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 6, 22, 236),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) {
                      return MovieCard(
                        recentEpisode: listRecentEpisodes[index],
                      );
                    },
                    itemCount: listPopularAnime.length,
                  ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: const Text(
              "Popular Anime",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 6, 22, 236),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) {
                      return MovieCard(anime: listPopularAnime[index]);
                    },
                    itemCount: listPopularAnime.length,
                  ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: const Text(
              "Top Airing Anime",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 6, 22, 236),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) {
                      return MovieCard(anime: listTopAiringAnime[index]);
                    },
                    itemCount: listTopAiringAnime.length,
                  ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: const Text(
              "Anime Movies",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 6, 22, 236),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) {
                      return MovieCard(anime: listAnimeMovies[index]);
                    },
                    itemCount: listAnimeMovies.length,
                  ),
          ),
        ],
      ),
    );
  }
}
