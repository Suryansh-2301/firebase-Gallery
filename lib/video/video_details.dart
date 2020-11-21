import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatefulWidget {
  final String url;

  VideoDetails({this.url});

  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {

  int _progress = 0;
  VideoPlayerController _controller;
  bool playing = false;

  @override
  void initState() {
    
    _controller = VideoPlayerController.network(widget.url);
    _controller.initialize();

    ImageDownloader.callback(onProgressUpdate:(String imageId, int progress){
      setState(() {
        _progress = progress;
      });
    });
    
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget play() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.green[900])
        ),
      onPressed: () {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
         playing = true; 
        });
      },
      color: Colors.green,
      child: Text(
        'Play',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
    );
  }

    Widget pause() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red[900])
        ),
      onPressed: () {
        setState(() {
          _controller.pause();
         playing = false; 
        });
      },
      color: Colors.red,
      child: Text(
        'Pause',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                child: Center(
                  child: Hero(
                    tag: 'VidDetails',
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      child: VideoPlayer(_controller)
                      ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(height:5),
            Column(
              children: [
                Container(
                  child: playing != true ? play() : pause(),
                ),
                SizedBox(height: 50,),
                Container(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.lightBlue,
                    valueColor: new AlwaysStoppedAnimation(Colors.red),
                    value: _progress.toDouble() / 100,
                  ),
                ),
                SizedBox(height:30),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 0))
                        ]),
                    child: IconButton(
                      iconSize: 42,
                      color: Colors.white,
                      icon: Icon(Icons.file_download),
                      onPressed: () async {
                        await ImageDownloader.downloadImage(widget.url,
                            destination: AndroidDestinationType.custom(
                                directory: 'Pictures'));
                      },
                    ),
                  ),
                  SizedBox(height:6),
                  Text(
                    'Download Video',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height:10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}