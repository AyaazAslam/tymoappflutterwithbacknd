import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeading extends StatelessWidget {
  final String mainText;
  final String subText;
  final String logo;
  final double fontsize;
  final double logosize;

  const AuthHeading(
      {super.key, required this.mainText,
      required this.subText,
      required this.logo,
      required this.fontsize,
      required this.logosize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Text(
              mainText,
              style: GoogleFonts.poppins(
                  fontSize: fontsize,
                  color: const Color(0xff000221),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 40,
                width: 40,
                child: Image.asset(logo,
                    height: 40,
                    width: 50,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high)), //logo),
            //child: Image(image: AssetImage("images/tym.jpg"))),
          ],
        ),
        Text(
          subText,
          style: GoogleFonts.poppins(
              fontSize: fontsize,
              color: const Color(0xff000221),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
