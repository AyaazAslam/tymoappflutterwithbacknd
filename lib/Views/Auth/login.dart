// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/user_controller.dart';
import 'package:flutter_application_1/Views/Auth/forgot_password.dart';
import 'package:flutter_application_1/Views/Auth/register.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_heading.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_application_1/interfaces/Auth/login_services.dart';
// import 'package:flutter_application_1/show_custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserController abc = UserController();

  // final LoginServices loginServices = LoginServices();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  // void dispose() {
  //   loginServices.emailController.dispose();
  //   loginServices.passController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tyamoo",
          
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        // backgroundColor: const Color(0xff000221),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeading(
              mainText: "Sign into Tyamo",
              subText: "& continue winning\ncrypto Traders",
              logo: "images/tym.jpg",
              fontsize: height * 0.02,
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
            SizedBox(height: height * 0.025),

            AuthTextField(
              labelText: "Password",
              controller: passWordController,
              icon: Icons.password,
              size: height * 0.03,
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(height: height * 0.035),

            SizedBox(
              width: double.infinity,
              height: height * 0.065,
              child: ElevatedButton(
                onPressed: () {
                  abc.signIn(
                    emailController.text.trim(),
                    passWordController.text.trim(),
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2f76EA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Login",
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

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const ForgotPassword(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                    color: const Color(0xffc1272D),
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.06),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff5A5B5B),
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    " Sign Up",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF2F76EA),
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w600,
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
