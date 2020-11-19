import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  CollectionReference vidColRef;

  @override
  void initState() {
    vidColRef = FirebaseFirestore.instance.collection('videosUrl');
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: vidColRef.snapshots(includeMetadataChanges: true),
        builder: (context,snapshot){
          if(snapshot.data?.documents == null && !snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return Hero(
            tag: 'VideoHero',
            child: Container(
              child: StaggeredGridView.countBuilder(
                itemCount: snapshot.data.documents.length,
                crossAxisCount: 2,
                itemBuilder: (context,index) => GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 0))
                            ]),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                          child: Center(child: Text('TODO: video Thumbnail here')),
                        ),
                  ),
                  onTap: (){
                    print('Details page open');
                  },
                ),
                staggeredTileBuilder: (index) =>
                  StaggeredTile.count(1, index.isEven ? 1.2 : 1.8),
              ),
            ),
          ); 
        },
      ),
    );
  }
}