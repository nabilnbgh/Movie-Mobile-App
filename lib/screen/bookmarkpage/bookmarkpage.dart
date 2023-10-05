import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_application/model/anime.dart';
import 'package:movie_application/model/bookmark.dart';
import 'package:movie_application/screen/searchpage/searchcard.dart';
import 'package:movie_application/service/apiservice.dart';
import 'package:movie_application/service/databaseservice.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  DatabaseService databaseService = DatabaseService();
  APIService apiService = APIService();
  CancelToken listDetailAnimeToken = CancelToken();
  List<Bookmark>? listBookmark;
  bool isLoading = true;
  void getData(String uid) async {
    try {
      listBookmark = await databaseService.getAllUserBookmarks(uid);
      if (listBookmark == null) {
        throw (Exception("List bookmark or List Detail Anime is Null"));
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of(context);
    if (user != null) {
      getData(user.uid);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Bookmarks",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 6, 22, 236),
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SearchCard(
                          anime: Anime(
                            listBookmark![index].animeImg,
                            listBookmark![index].animeTitle,
                            animeId: listBookmark![index].animeId,
                            animeUrl: "",
                          ),
                        );
                      },
                      itemCount: listBookmark!.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
