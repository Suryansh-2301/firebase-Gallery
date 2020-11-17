import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_gallery/custom_fab.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_gallery/alert.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  
  final picker = ImagePicker(); 
  File video;
  String _fileUrl;
  CollectionReference vidColRef;
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

//   Future uploadFile() async {
//    Reference storageReference = FirebaseStorage.instance
//    .ref()
//    .child('videos/${Path.basename(video.path)}');

//    UploadTask uploadVideo = storageReference.putFile(video);
//    await uploadVideo.whenComplete;
//    print('File uploaded');

//    storageReference.getDownloadURL().then((fileUrl) {
//      setState(() {
//        _fileUrl = fileUrl;
//      });
//    }).whenComplete(() async {
//      await vidColRef.add({'url':_fileUrl});
//      print('link added to database');
//    });
//  }

 @override
  void initState() {
    vidColRef = FirebaseFirestore.instance.collection('videosUrl');
    super.initState();
  }

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

         // uploadFile();
        },
      ),

    );
  }
}