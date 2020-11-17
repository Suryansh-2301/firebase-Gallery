import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_gallery/custom_fab.dart';

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  File _image;
  final picker = ImagePicker();
  String _uploadFileURL;
  CollectionReference imgColRef;

  @override
  void initState() {
    imgColRef = FirebaseFirestore.instance.collection('imageUrls');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: new GridView.builder(
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              child: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.center,
              child: new Text('Item $index'),
            ),
          ));
        },
      ),
      floatingActionButton: CustomFab(
        fromGallery: () async {
          final pickedFile = await picker.getImage(source: ImageSource.gallery);
          setState(() {
            _image = File(pickedFile.path);
          });

          if (pickedFile.path == null) retrieveLostData();
        },
        fromCamera: () async {
          final pickedFile1 = await picker.getImage(source: ImageSource.camera);
          setState(() {
            _image = File(pickedFile1.path);
          });

          if (pickedFile1.path == null) retrieveLostData();
        },
      ),
    );
  }



  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }
}
