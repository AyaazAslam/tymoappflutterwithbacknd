import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ImageView extends StatelessWidget {
  String url;
  ImageView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        heroAttributes: PhotoViewHeroAttributes(tag: "tag"),
        imageProvider: NetworkImage(
          "https://cdn.pixabay.com/photo/2015/10/01/19/05/car-967470_1280.png",
        ),
        // AssetImage("images/office.jpg"),
      ),
    );
  }
}
