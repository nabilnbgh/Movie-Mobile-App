import 'package:dio/dio.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/model/apiservice.dart';
import 'package:movie_application/model/episode.dart';
import 'package:movie_application/model/vidcdn.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key, required this.listEpisodes});

  final List<Episode> listEpisodes;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  FlickManager? flickManager;
  APIService apiService = APIService();
  CancelToken getURLCancelToken = CancelToken();
  VidCDN? vidCDN;
  int selectedIndex = -1;
  bool isLoading = false;
  void getStreamingURL(int index) async {
    final epsId = widget.listEpisodes[index].episodeId;
    vidCDN = await apiService.getStreamingURL(epsId, getURLCancelToken);
    setState(() {
      isLoading = false;
      if (flickManager == null) {
        flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(
                vidCDN!.sources[0].file,
                httpHeaders:
                    Map<String, String>.of({'referer': vidCDN!.referer})));
      } else {
        flickManager!.handleChangeVideo(VideoPlayerController.network(
            vidCDN!.sources[0].file,
            httpHeaders: Map<String, String>.of({'referer': vidCDN!.referer})));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExpansionTile(
                      iconColor: Colors.white,
                      initiallyExpanded: true,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      title: const Text(
                        'List Of Episodes',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      children: [
                        GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2.0, crossAxisCount: 4),
                            itemCount: widget.listEpisodes.length,
                            itemBuilder: (context, index) {
                              return TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (flickManager != null) {
                                        flickManager!.flickControlManager!
                                            .pause();
                                      }
                                      selectedIndex = index;
                                      isLoading = true;
                                    });
                                    getStreamingURL(index);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  child: Text(
                                    widget.listEpisodes[index].episodeNum
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: selectedIndex != index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ));
                            }),
                      ]),
                ],
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 6, 22, 236),
                      ),
                    ),
                  )
                : flickManager == null
                    ? Container()
                    : FlickVideoPlayer(
                        flickManager: flickManager!,
                        flickVideoWithControlsFullscreen:
                            const FlickVideoWithControls(
                          videoFit: BoxFit.fitHeight,
                          controls: FlickLandscapeControls(),
                        ),
                        preferredDeviceOrientationFullscreen: const [
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (flickManager != null) {
      flickManager!.dispose();
    }
    super.dispose();
  }
}
