import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/model/animedetail.dart';
import 'package:movie_application/model/apiservice.dart';

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
  bool isLoading = true;
  void getData() async {
    animeDetail = await apiService.getDetailAnime(widget.animeId, cancelToken);

    setState(() {
      print(animeDetail!.totalEpisodes);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
              : Column(
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Genres: ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Row(
                              children: animeDetail!.genres.map((e) {
                            final isLast = animeDetail!.genres.indexOf(e) ==
                                animeDetail!.genres.length - 1;
                            !isLast ? e = '$e, ' : e;
                            return Text(
                              e,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          }).toList()),
                        ],
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
                        'List Of Episodes',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
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
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return TextButton(
                              onPressed: () {
                                print('tapped');
                              },
                              child: Text(animeDetail!
                                  .episodesList[index].episodeNum
                                  .toString()));
                        },
                        itemCount: animeDetail!.episodesList.length,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
