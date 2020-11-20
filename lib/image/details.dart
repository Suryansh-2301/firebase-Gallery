import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class DetailScreen extends StatefulWidget {
  final String url;
  DetailScreen({this.url});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _progress = 0;
  @override
  void initState() {
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    child: Center(
                      child: Hero(
                        tag: 'Detail',
                        child: Image.network(widget.url),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )),
                SizedBox(height:15),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                  'Download Image',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height:10),
              ],
            )
          ],
        ),
      ),
    );
  }
}