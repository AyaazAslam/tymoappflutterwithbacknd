import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailWidgets extends StatelessWidget {
  final String type;
  final String val;
  final IconData icon;
  final Color color;

  const ProfileDetailWidgets({super.key, 
    required this.type,
    required this.val,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        height: height * .05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            SizedBox(width: width * .01),
            Icon(icon, color: Colors.black),
            SizedBox(width: width * .02),
            Text(
              type,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    val,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
