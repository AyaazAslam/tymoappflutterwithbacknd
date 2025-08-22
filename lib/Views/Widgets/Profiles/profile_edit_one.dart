
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileEditOneWidget extends StatelessWidget {
  final String text;
  
  final Color color;
  const ProfileEditOneWidget({super.key, 
    
    required this.text,
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
            
          ],
        ),
      ),
    );
  }
}