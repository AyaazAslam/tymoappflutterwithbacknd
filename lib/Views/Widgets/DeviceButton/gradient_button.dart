import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButtonWidget extends StatelessWidget {
  final String title;
  final List<Color> clr;
  final double height;
  final double width;
  final Color overlaycolor;
  final VoidCallback? onPressed;

  const GradientButtonWidget({super.key, 
    required this.clr,
    required this.title,
    required this.overlaycolor,
    required this.height,
    required this.width,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: clr,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(2, 2),
            blurRadius: 4,
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed ?? () {},
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
