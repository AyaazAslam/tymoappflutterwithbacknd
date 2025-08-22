import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;
  final IconData icon;
  final double size;
  final TextEditingController controller;

  const AuthTextField({
    super.key,
    required this.size,
    required this.icon,
    required this.keyboardType,
    required this.labelText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.none,
      obscureText: obscureText,
      autofocus: false,
      style: GoogleFonts.poppins(fontSize: size),
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: const Color(0xffE7E7F2),
        filled: true,
        prefixIcon: Icon(icon, size: size),
        prefixIconColor: const Color(0xff000221),
        label: Text(labelText),
        labelStyle: GoogleFonts.poppins(fontSize: size, color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
