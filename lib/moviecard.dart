import 'package:flutter/material.dart';
import 'package:movie_application/detailpage/detailpage.dart';
import 'package:movie_application/model/anime.dart';
import 'package:movie_application/model/recentepisode.dart';
import 'package:movie_application/videoplayer/playerpage.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, this.anime, this.recentEpisode});
  final Anime? anime;
  final RecentEpisode? recentEpisode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final pushedPage = recentEpisode == null
            ? DetailPage(animeId: anime!.animeId)
            : PlayerPage(
                listEpisodes: const [],
                recentEpisode: recentEpisode,
              );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pushedPage));
      },
      child: Card(
        elevation: 10,
        child: anime != null
            ? Image.network(
                anime!.animeImg,
                height: 250,
              )
            : Image.network(
                recentEpisode!.animeImg,
                height: 250,
              ),
      ),
    );
  }
}
