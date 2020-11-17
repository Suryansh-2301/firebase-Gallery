import 'package:firebase_gallery/video.dart';
import 'package:flutter/material.dart';
import 'package:firebase_gallery/images.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with SingleTickerProviderStateMixin{

  TabController controller;
  ScrollController viewController;

  void initState(){
    super.initState();
    controller = new TabController(length: 2, vsync: this);
    viewController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: new NestedScrollView(
        controller: viewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Center(child: new Text("Gallery App")),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Colors.deepOrangeAccent,
              bottom: new TabBar(
                tabs: <Tab>[
                  new Tab(text: "Images"),
                  new Tab(text: "Videos"),
                ],
                indicatorColor: Colors.white,
                controller: controller,
              ),
            ),
          ];
        },
        body: new TabBarView(
          children: <Widget>[
            Images(),
            Video(),
          ],
          controller: controller,
        ),
      ),
    );
  }
}


