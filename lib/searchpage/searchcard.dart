import 'package:flutter/material.dart';
import 'package:movie_application/model/anime.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.anime});
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
      height: 100,
      width: (MediaQuery.of(context).size.width - 100) * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(anime.animeImg, width: 90, fit: BoxFit.cover),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              anime.animeTitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Icon(
              Icons.play_circle_outline_sharp,
              size: 48,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
