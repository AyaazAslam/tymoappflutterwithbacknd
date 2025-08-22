import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceSpaceWidget extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final String type;
  final Color txtclr;

  const DeviceSpaceWidget({super.key, 
    required this.title,
    required this.height,
    required this.width,
    required this.type,
    required this.txtclr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: txtclr,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Text(
            type,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w900,
              color: Colors.red,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
