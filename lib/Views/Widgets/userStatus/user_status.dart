import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserStatusWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color clr;
  final Color txtclr;
  final String text;
  final String imagePath;

  const UserStatusWidget({
    super.key,
    required this.height,
    required this.width,
    required this.clr,
    required this.txtclr,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: Image.asset(imagePath).image,
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // Optional: handle tap
        },
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: txtclr,
          ),
          textAlign: TextAlign.center,
          textScaleFactor: 1,
        ),
      ),
    );
  }
}
