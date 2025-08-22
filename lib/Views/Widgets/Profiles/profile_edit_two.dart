import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileEditTwoWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final String type;
  const ProfileEditTwoWidget({super.key, 
    required this.icon,
    required this.text,
    required this.type,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      child: SizedBox(
        height: height * .05,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1),
            ),
            Text(
              type,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1),
            ),
            Icon(icon, color: color),
          ],
        ),
      ),
    );
  }
}
