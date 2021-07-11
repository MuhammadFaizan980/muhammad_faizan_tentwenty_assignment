import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayTrailerScreen extends StatefulWidget {
  String _videoId;

  PlayTrailerScreen(this._videoId);

  @override
  _PlayTrailerScreenState createState() => _PlayTrailerScreenState();
}

class _PlayTrailerScreenState extends State<PlayTrailerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget._videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                onEnded: (_) {
                  Navigator.pop(context);
                },
                controller: _controller,
              ),
              builder: (BuildContext, player) => player,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
