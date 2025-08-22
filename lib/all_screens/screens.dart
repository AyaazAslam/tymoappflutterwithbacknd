import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Auth/Features/Album/album_new_post.dart';
import 'package:flutter_application_1/Views/Auth/login.dart';

class AllScreens extends StatefulWidget {
  const AllScreens({super.key});

  @override
  State<AllScreens> createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 300,
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                "Login Screen",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlbumNewPost()),
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 300,
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                "Album Screen",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
