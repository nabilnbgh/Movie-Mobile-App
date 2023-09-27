import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/model/anime.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.anime});
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: 150,
                child: Image.network(
                  anime.animeImg,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 120,
                width: 90,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  anime.animeTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Icon(Icons.play_circle_outline_sharp),
        ],
      ),
    );
  }
}
