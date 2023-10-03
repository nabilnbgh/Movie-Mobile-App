import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/model/anime.dart';
import 'package:movie_application/service/apiservice.dart';
import 'package:movie_application/screen/searchpage/searchcard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Anime> listSearchAnime = [];
  String keyword = "";
  CancelToken cancelToken = CancelToken();
  bool isLoading = false;
  APIService apiService = APIService();
  TextEditingController searchController = TextEditingController();

  void getData() async {
    setState(() {
      isLoading = true;
    });
    listSearchAnime = await apiService.getSearchAnime(keyword, cancelToken);
    if (!cancelToken.isCancelled) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Container(
          height: 35,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
          ),
          child: TextField(
            onChanged: (text) {
              keyword = text;
              getData();
            },
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.white,
              hintText: "Search Anime",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 6, 22, 236),
                      ),
                    ),
                  )
                : const Text(
                    "Top Search",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SearchCard(anime: listSearchAnime[index]);
              },
              itemCount: listSearchAnime.length,
            ),
          ),
        ],
      ),
    );
  }
}
