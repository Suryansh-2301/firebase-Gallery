import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnail extends StatefulWidget {

  final String url;
  VideoThumbnail({this.url});

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  
  VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url)
    ..initialize().then((_) {
    setState(() {});  //when your thumbnail will show.
  });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VideoPlayer(_controller),
    );
  }
}