import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/user_controller.dart';
import 'package:flutter_application_1/Views/Auth/login.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_heading.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

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
  final TextEditingController nameController = TextEditingController();

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confrimPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  // ✅ Pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  // ✅ Upload image to Firebase Storage
  Future<String> _uploadImageToStorage(String uid) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("ayazprofilePictures")
          .child("$uid.jpg");

      await ref.putFile(_pickedImage!);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint("Image upload error: $e");
      return "";
    }
  }

  Future<void> _registerUser(BuildContext context) async {
    if (passwordController.text.trim() !=
        confrimPasswordController.text.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      // ✅ Create user in Firebase Auth first
      final userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      String imageUrl = "";

      if (_pickedImage != null) {
        imageUrl = await _uploadImageToStorage(userCred.user!.uid);
      }

      // ✅ Save to Firestore using your controller
      UserController.signUp(
        imageUrl: imageUrl,
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        confirmPass: confrimPasswordController.text.trim(),
        context: context,
      );

      emailController.clear();
      passwordController.clear();
      confrimPasswordController.clear();
      nameController.clear();
      setState(() => _pickedImage = null);
    } catch (e) {
      debugPrint("Register error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeading(
              mainText: "Sign Up with Tyamo",
              subText: "& continue winning\ncrypto Traders",
              logo: "images/tym.jpg",
              fontsize: height * 0.015,
              logosize: height * 0.05,
            ),
            SizedBox(height: height * 0.03),

            // 🔹 Profile Image Picker
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: height * 0.06,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _pickedImage != null
                      ? FileImage(_pickedImage!)
                      : null,
                  child: _pickedImage == null
                      ? Icon(
                          Icons.camera_alt,
                          size: height * 0.04,
                          color: Colors.grey[700],
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(height: height * 0.03),

            AuthTextField(
              labelText: "username",
              controller: nameController,
              icon: Icons.person,
              size: height * 0.03,
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
            SizedBox(height: height * 0.02),

            AuthTextField(
              labelText: "Email",
              controller: emailController,
              icon: Icons.email,
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
                onPressed: () => _registerUser(context),
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
