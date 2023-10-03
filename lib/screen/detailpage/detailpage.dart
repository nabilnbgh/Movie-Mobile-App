import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/model/animedetail.dart';
import 'package:movie_application/service/apiservice.dart';
import 'package:movie_application/screen/videoplayer/playerpage.dart';
import 'package:movie_application/service/databaseservice.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.animeId});
  final String animeId;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  APIService apiService = APIService();
  AnimeDetail? animeDetail;
  CancelToken cancelToken = CancelToken();
  CancelToken getURLCancelToken = CancelToken();
  DatabaseService databaseService = DatabaseService();
  bool isLoading = true;
  bool isBookmarked = false;
  User? user;

  void getData() async {
    animeDetail = await apiService.getDetailAnime(widget.animeId, cancelToken);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget setGenre() {
    var text = "Genres: ";
    for (var e in animeDetail!.genres) {
      final isLast =
          animeDetail!.genres.indexOf(e) == animeDetail!.genres.length - 1;
      !isLast ? text += '$e, ' : text += e;
    }
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontSize: 12,
      ),
      maxLines: 2,
    );
  }

  void getBookmarkStatus(String uid, String animeId) async {
    bool status = await databaseService.getBookmarkStatus(uid, animeId);
    if (mounted) {
      setState(() {
        isBookmarked = status;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User?>(context);
    if (user != null) {
      getBookmarkStatus(user!.uid, widget.animeId);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: animeDetail != null
              ? IconButton(
                  color: Colors.white,
                  icon: isBookmarked
                      ? const Icon(Icons.bookmark_remove_outlined)
                      : const Icon(Icons.bookmark_add_outlined),
                  onPressed: () {
                    if (user != null) {
                      if (isBookmarked) {
                        databaseService.deleteBookmark(
                            user!.uid, widget.animeId);
                      } else {
                        databaseService.createCollectionForUser(
                            user!.uid,
                            widget.animeId,
                            animeDetail!.animeTitle,
                            animeDetail!.animeImg);
                      }
                    } else {
                      const snackBar = SnackBar(
                        content:
                            Text("You are not log in, please log in first"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                )
              : Container(),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 6, 22, 236),
                    ),
                  ),
                )
              : animeDetail != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          animeDetail!.animeImg,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: 0.0,
                            maxHeight: 100,
                          ),
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            animeDetail!.animeTitle,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 3,
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: 0.0,
                            maxHeight: 100,
                          ),
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            'Synopsis',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          child: ExpandableText(
                            animeDetail!.synopsis,
                            maxLines: 3,
                            expandText: 'show more',
                            collapseText: 'show less',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Text(
                                "Status: ",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Text(
                                animeDetail!.status,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            child: setGenre()),
                        animeDetail!.episodesList.isEmpty
                            ? Container()
                            : TextButton.icon(
                                icon: const Icon(Icons.movie),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlayerPage(
                                                listEpisodes:
                                                    animeDetail!.episodesList,
                                              )));
                                },
                                label: const Text("Watch Now"),
                              )
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: () async => getData(),
                      child: const Center(
                        child: Text(
                          "Error To Fetch Data",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
