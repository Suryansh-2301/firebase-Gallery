import 'package:flutter/material.dart';
import 'package:firebase_gallery/custom_fab.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  
  final picker = ImagePicker(); 
  File _video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery App'),
        backgroundColor: Colors.blue,
      ),

      body: Center(child: Text('this is the videos page'),),

      floatingActionButton: CustomFab(
        fromCamera: () async {
          final pickedFile = await picker.getVideo(source: ImageSource.camera);
          setState(() {
            _video = File(pickedFile.path);
          });
        },
        fromGallery: () async {
          final pickedFile = await picker.getVideo(source: ImageSource.gallery);
          setState(() {
            _video = File(pickedFile.path);
          });
        },
      ),

    );
  }
}