import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class VideoDetails extends StatefulWidget {
  final String url;

  VideoDetails({this.url});

  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {

  int _progress = 0;

  @override
  void initState() {
    ImageDownloader.callback(onProgressUpdate:(String imageId, int progress){
      setState(() {
        _progress = progress;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: Center(
                child: Hero(
                  tag: 'VidDetails',
                  child: Text('this will contain the video'),
                ),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          Column(
            children: [
              Container(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                  valueColor: new AlwaysStoppedAnimation(Colors.red),
                  value: _progress.toDouble() / 100,
                ),
              ),
              Container(
                child: IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () async {
                  await ImageDownloader.downloadImage(widget.url,destination: AndroidDestinationType.custom(directory: 'Pictures'));
                },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}