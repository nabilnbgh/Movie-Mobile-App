import 'package:flutter/material.dart';
import 'package:movie_application/model/anime.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.anime});
  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Image.network(
        anime.animeImg,
        height: 250,
      ),
    );
  }
}
