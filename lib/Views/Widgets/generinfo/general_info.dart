import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralInfoWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color clr;
  final Color txtclr;
  final String text;

  const GeneralInfoWidget({
    super.key,
    required this.height,
    required this.width,
    required this.clr,
    required this.txtclr,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          // Optional: handle tap
        },
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: txtclr,
            ),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
      ),
    );
  }
}
