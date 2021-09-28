import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parcours_numerique_app/const.dart';
import 'package:parcours_numerique_app/assets/data/videos.dart' as data;
import 'package:parcours_numerique_app/models/video_model.dart';
import 'package:parcours_numerique_app/views/video_card.dart';
import 'package:url_launcher/url_launcher.dart';

class VideosDrawer extends StatelessWidget {
  const VideosDrawer({Key? key}) : super(key: key);
  
  List<VideoCard> videosCard(List<Video>videos) {
    List<VideoCard> listOfVideosCard = [];
    for (int i = 0; i < videos.length; i++) {
      listOfVideosCard.add(VideoCard(video: videos[i]));
    }
    return listOfVideosCard;
  }

  _launchURL(url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Video> videos = data.videos;
    return Drawer(
      child: CustomScrollView(
        slivers: [
          /**
          SliverAppBar(
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('lib/assets/img/logo.png'),

            ),
            expandedHeight: 100,
            //collapsedHeight: 120,
          ), */
          SliverAppBar(
            //toolbarHeight: 20,
            backgroundColor: ACCENT_COLOR,
            title: Text('Espace Vidéos'),
            floating: true,
            primary: true,
            pinned: true,
            actions: [
              IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return InkWell(child: VideoCard(video: videos[index]), onTap: () {
                  _launchURL(videos[index].url);
                },);
              },
              childCount: 6, // 1000 list items
            ),
          ),
        ],
      )
    );
  }
}


/**

    Container(
    color: ACCENT_COLOR,
    child: ListView(
    padding: EdgeInsets.zero,
    children: [
    DrawerHeader(
    padding: EdgeInsets.symmetric(horizontal: 0),
    decoration: BoxDecoration(color: Colors.white),
    child: Column(children: [
    Expanded(child: Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Image.asset('lib/assets/img/logo.png'),
    )),
    Expanded(child: Container(child: Center(child: Text('Vidéos', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)), color: ACCENT_COLOR, width: double.infinity,)),
    Divider(
    height: 1,
    )
    ],), ),
    Column(
    children: videosCard(videos),
    )
    ],
    ),
    ),

    Expanded(child: Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Image.asset('lib/assets/img/logo.png'),
    )),
    Expanded(child: Container(child: Center(child: Text('Vidéos', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)), color: ACCENT_COLOR, width: double.infinity,)),
    Divider(
    height: 1,
    )

    */