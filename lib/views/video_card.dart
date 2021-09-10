import 'package:flutter/material.dart';
import 'package:parcours_numerique_app/models/video_model.dart';

class VideoCard extends StatelessWidget {
  final Video video;
  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: 30,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Image.asset(video.imagePath),
          //Text(video.name)
        ],),
      ),
    );
  }
}
