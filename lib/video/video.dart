import 'package:firebase_gallery/video/videoscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_gallery/shared/custom_fab.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_gallery/video/alert.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  
  final picker = ImagePicker(); 
  File video;
  AlertBox obj;

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if(response.isEmpty){
      return;
    }
    if(response.file != null){
      setState(() {
          video = File(response.file.path);
      });
    }
    else{
      print(response.file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: VideoScreen(),

      floatingActionButton: CustomFab(
        fromCamera: () async {
          final pickedFile = await picker.getVideo(source: ImageSource.camera);
          setState(() {
            video = File(pickedFile.path);
          });

          if(pickedFile == null) retrieveLostData(); 

          obj = new AlertBox(video);
          obj.showMyDialog(context);
        },

        fromGallery: () async {
          final pickedFile = await picker.getVideo(source: ImageSource.gallery);
          setState(() {
            video = File(pickedFile.path);
          });

          if(pickedFile == null) retrieveLostData();

          obj = new AlertBox(video);
          obj.showMyDialog(context);
        },
      ),
    );
  }
}