import 'dart:ui' as prefix0;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balloon_slider/flutter_balloon_slider.dart'
    show BalloonSlider;
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Views/Auth/Features/Album/image_view.dart';
import 'package:flutter_application_1/Views/Auth/Features/Album/my_album.dart';
import 'package:page_transition/page_transition.dart';

class AlbumPost extends StatefulWidget {
  final String imageUrl;
  const AlbumPost({super.key, required this.imageUrl});

  @override
  State<AlbumPost> createState() => _AlbumPostState();
}

class _AlbumPostState extends State<AlbumPost> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60),
                bottomLeft: Radius.circular(60),
              ),
              child: Container(
                width: width,
                height: height * .62,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imageUrl),
                    fit: BoxFit.cover, // Add BoxFit value here
                  ),
                ),
                child: BackdropFilter(
                  filter: prefix0.ImageFilter.blur(sigmaX: 7, sigmaY: 14),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyAlbum(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * .13,
                              width: width * .13,
                              child: Image(image: AssetImage("images/tym.jpg")),
                              //Image(image: AssetImage("images/tym.jpg")),
                            ),
                            Padding(padding: EdgeInsets.all(20)),
                            // GFAvatar(backgroundColor: Colors.blue, size: 30),
                            GFAvatar(
                              backgroundColor: Colors.blue,
                              shape: GFAvatarShape.circle,
                              size: 30,
                              child: Icon(Icons.person),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),

                          child: GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Hero(
                                tag:
                                    "https://cdn.pixabay.com/photo/2015/10/01/19/05/car-967470_1280.png",
                                child: Image.network(
                                  "https://cdn.pixabay.com/photo/2015/10/01/19/05/car-967470_1280.png",
                                ),
                              ),
                              // child: Image(
                              //   image: AssetImage(widget.imageUrl),
                              //   fit: BoxFit.cover,
                              //   height: height * 0.34,
                              //   width: width,
                              // ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ImageView(url: "https://cdn.pixabay.com/photo/2015/10/01/19/05/car-967470_1280.png"),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: BalloonSlider(
                            value: 0.5,
                            ropeLength: 55,
                            showRope: true,
                            onChangeStart: (val) {},
                            onChanged: (val) {},
                            onChangeEnd: (val) {},
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Caption",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  GestureDetector(
                    child: Icon(Icons.edit, color: Colors.blue),
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.noHeader,
                        dismissOnBackKeyPress: true,
                        isDense: false,
                        btnOkOnPress: () {
                          // Handle OK press here
                          // print("New caption: ${controller.text}");
                        },
                        title: "Edit Caption",
                        body: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: TextField(
                              // controller: controller,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: null, // not 'Null' with capital N
                              decoration: InputDecoration(
                                labelText: "Enter a new caption",
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Color(0xff671AFC),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // not 'focuseBorder'
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Color(0xff671AFC),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              //keyboardType:
                            ),
                          ),
                        ),
                      ).show();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),

              child: Row(
                children: [
                  Text(
                    "A beautiful scenary",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: width * .03),
                  Icon(Icons.favorite_outline_outlined),
                  Icon(Icons.favorite_outline_outlined),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              "show your love !",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            ListTile(
              leading: GFAvatar(backgroundColor: Colors.blue, size: 30),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gafree123",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Just Now",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "I am absolutly love with ",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: width * .03),
                  Icon(Icons.favorite_outline_outlined, color: Colors.red),
                  Icon(Icons.favorite_outline_outlined, color: Colors.red),
                  Icon(Icons.favorite_outline_outlined, color: Colors.red),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 70),
            //   child: Icon(Icons.favorite_outline_outlined, color: Colors.red),
            // ),
            // SizedBox(height: 10),
            Center(
              child: Container(
                padding: EdgeInsets.all(3),
                height: height * .06,
                width: width * .55,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios_new_sharp),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
