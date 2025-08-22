import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Views/Auth/Features/Album/album_post.dart';
import 'package:staggered_grid_view/flutter_staggered_grid_view.dart';

class MyAlbum extends StatefulWidget {
  const MyAlbum({super.key});

  @override
  State<MyAlbum> createState() => _MyAlbumState();
}

class _MyAlbumState extends State<MyAlbum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopSection(context),
            Padding(
              padding: EdgeInsets.all(12),
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 15,
                crossAxisCount: 4,
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(2, index.isEven ? 2 : 3);
                },
                itemBuilder: (context, index) {
                  return _buildGridItem(context, index);
                },
                itemCount: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        color: Color(0xffFafad2),
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          // Header Banner
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffF7DB00), Color(0xffF7A100)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Gallery",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 40,
                  child: Icon(Icons.person),
                ),
                Text(
                  "Asghar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Tell your partner what album means to you",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stats Row
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatColumn(
                  valueStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),

                  label: "Total updates",
                  value: "0",
                  // style: labelStyle,
                  // valueStyle: valueStyle,
                ),
                _buildEditButton(context),
                _StatColumn(
                  valueStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  label: "Photos",
                  value: "0",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.noHeader,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Enter Album Description",
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Nunito",
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 2,
            ),
          ),
          btnOkOnPress: () {},
        ).show();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xff633494), Color(0xff5656AC)],
          ),
        ),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    List<dynamic> imagesList = [
      "images/office.jpg",
      "images/office1.jpg",
      "images/office2.jpg",
      "images/office.jpg",
      "images/outdoor.jpeg",
      "images/office2.jpg",
      "images/office.jpg",
      "images/outdoor.jpeg",
      "images/office2.jpg",
    ];
    return FocusedMenuHolder(
      menuItems: [],
     
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumPost(imageUrl: imagesList[index]),
          ),
        );
      },
      child: Card(
        child: SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(15),
            child: Image(
              image: AssetImage(imagesList[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  // final TextStyle style;
  final TextStyle valueStyle;

  const _StatColumn({
    required this.label,
    required this.value,
    // required this.style,
    required this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Text(value, style: valueStyle),
      ],
    );
  }
}
