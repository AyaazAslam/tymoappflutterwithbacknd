// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/user_controller.dart';
// import 'package:flutter_application_1/Model/my_user.dart';
import 'package:flutter_application_1/Views/Auth/login.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_heading.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_application_1/show_custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserController abc = UserController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrimPasswordController =
      TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confrimPasswordController.dispose();
    super.dispose();
  }

  // RegisterServices registerServices = RegisterServices();
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
        // backgroundColor: const Color(0xff000221),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeading(
              mainText: "Sign Up with Tyamo",
              subText: "& continue winning\ncrypto Traders",
              logo: "images/tym.jpg",
              fontsize: height * 0.020,
              logosize: height * 0.05,
            ),
            SizedBox(height: height * 0.04),

            AuthTextField(
              labelText: "Email",
              controller: emailController,
              icon: Icons.alternate_email,
              size: height * 0.03,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            SizedBox(height: height * 0.02),

            AuthTextField(
              labelText: "Password",
              controller: passwordController,
              icon: Icons.password,
              size: height * 0.03,
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(height: height * 0.02),

            AuthTextField(
              labelText: "Confirm Password",
              controller: confrimPasswordController,
              icon: Icons.lock_reset,
              size: height * 0.03,
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(height: height * 0.03),

            SizedBox(
              width: double.infinity,
              height: height * 0.065,
              child: ElevatedButton(
                onPressed: () {
                  UserController.signUp(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    confrimPasswordController.text.trim(),
                    context,
                  );
                  emailController.clear();
                  passwordController.clear();
                  confrimPasswordController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2f76EA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Register",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: height * 0.022,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.025),

            Text(
              "By registering, you agree to our terms and conditions.",
              style: GoogleFonts.poppins(
                color: const Color(0xff00c1AA),
                fontWeight: FontWeight.w500,
                fontSize: height * 0.018,
              ),
            ),
            SizedBox(height: height * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Registered?",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff808080),
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.018,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    " Sign In",
                    style: GoogleFonts.poppins(
                      color: const Color(0xff2f76EA),
                      fontWeight: FontWeight.w700,
                      fontSize: height * 0.018,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
