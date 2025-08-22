import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_heading.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_text_field.dart';
import 'package:flutter_application_1/interfaces/Auth/forgot_services.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgotServices forgotServices = ForgotServices();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tyamo",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff000221),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthHeading(
              mainText: "Forgot your Password",
              subText: "",
              logo: "images/tym.jpg",
              fontsize: height * 0.028,
              logosize: height * 0.07,
            ),
            SizedBox(height: height * 0.04),

            SizedBox(
              height: height * 0.18,
              child: Image.asset(
                "images/lock1.jpg",
                filterQuality: FilterQuality.high,
              ),
            ),
            SizedBox(height: height * 0.03),

            Text(
              "To request a new one, type your email address.\n"
              "A reset link will be sent to your email.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: height * 0.018,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: height * 0.03),

            AuthTextField(
              controller: forgotServices.emailController,
              size: height * 0.05,
              icon: Icons.alternate_email,
              keyboardType: TextInputType.emailAddress,
              labelText: "Email",
              obscureText: false,
            ),
            SizedBox(height: height * 0.04),

            SizedBox(
              width: double.infinity,
              height: height * 0.065,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Reset password logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2f76EA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Reset Password",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: height * 0.022,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
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
