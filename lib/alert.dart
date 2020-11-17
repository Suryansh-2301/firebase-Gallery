import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

class AlertBox {

  File vid;
  CollectionReference vidColRef;
  VideoPlayerController controller;

  AlertBox(File vid){
    this.vid = vid;
    getController();
  }

  Future uploadFile() async {

  vidColRef = FirebaseFirestore.instance.collection('videosUrl');
  
   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
   .ref()
   .child('videos/${Path.basename(vid.path)}');

   firebase_storage.UploadTask task = ref.putFile(vid);

   task.whenComplete(() async {
      print('file uploaded');
      await ref.getDownloadURL().then((fileURL) async {
        await vidColRef.add({'url': fileURL});
        print('link added to database');
      });
   });
   
 }


  void getController() {
    controller = VideoPlayerController.file(vid);
    controller.initialize();
  }

  void disposeController() {
    if(controller.value.isPlaying) controller.pause();
    controller.removeListener((){
      controller.dispose();
    });
  }

  Future<void> showMyDialog(context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Upload?'),
          content: Container(
            child:GestureDetector(
              onTap: controller.play,
              onDoubleTap: controller.pause,
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
                ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                disposeController();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                uploadFile();
                disposeController();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}