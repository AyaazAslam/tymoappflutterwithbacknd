// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/my_user.dart';
import 'package:flutter_application_1/Views/Auth/login.dart';
import 'package:flutter_application_1/Views/navbar.dart';
// import 'package:flutter_application_1/Views/profilies/profile_setup.dart';
import 'package:flutter_application_1/show_custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart'; // for hashing password

class UserController {
  static Future<void> signUp({
    required String imageUrl,
    required String name,
    required String email,
    required String password,
    required String confirmPass,
    required BuildContext context,
  }) async {
    if (email.isEmpty || password.isEmpty || confirmPass.isEmpty) {
      showCustomSnackbar(message: "Please fill all fields", context: context);
      return;
    }
    if (password != confirmPass) {
      showCustomSnackbar(message: "Passwords do not match", context: context);
      return;
    }

    try {
      // Check if email already exists
      var existingUser = await FirebaseFirestore.instance
          .collection("ayaztempUser")
          .where("email", isEqualTo: email)
          .get();

      if (existingUser.docs.isNotEmpty) {
        showCustomSnackbar(
          message: "User already exists with this email",
          context: context,
        );
        return;
      }

      // Generate unique UID
      String userId = const Uuid().v4();

      // Create user model
      MyUser model = MyUser(
        avatarUrl: imageUrl,
        username: name,
        email: email,
        password: password, // ideally hash this
        uid: userId,
        isLoadingStartupData: true,
      );

      // Save with UID as docId
      await FirebaseFirestore.instance
          .collection("ayaztempUser")
          .doc(userId)
          .set(model.toMap(), SetOptions(merge: true));

      showCustomSnackbar(message: "Sign Up Successful", context: context);

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.fade, child: const LoginPage()),
      );
    } catch (e) {
      showCustomSnackbar(message: e.toString(), context: context);
    }
  }

  void signIn(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomSnackbar(
        message: "Please fill all the fields",
        context: context,
      );
      return;
    }

    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("ayaztempUser")
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password) // 🔐 hash later
          .get();

      if (snapshot.docs.isNotEmpty) {
        // persist minimal session
        final data = snapshot.docs.first.data();
        final prefs = await SharedPreferences.getInstance();
        final String rawDisplay = (data['displayName'] ?? '').toString().trim();
        final String rawUsername = (data['username'] ?? '').toString().trim();
        final String rawEmail = (data['email'] ?? '').toString().trim();
        String finalDisplay = rawDisplay;
        if (finalDisplay.isEmpty) {
          finalDisplay = rawUsername.isNotEmpty
              ? rawUsername
              : (rawEmail.contains('@') ? rawEmail.split('@').first : rawEmail);
        }

        await prefs.setString('session_uid', data['uid'] ?? '');
        await prefs.setString('session_email', rawEmail);
        await prefs.setString('session_displayName', finalDisplay);
        await prefs.setString(
          'session_avatarUrl',
          (data['avatarUrl'] ?? '').toString(),
        );

        showCustomSnackbar(message: "Login Successful", context: context);

        Navigator.pushReplacement(
          context,
          PageTransition(type: PageTransitionType.fade, child: NavBarScreen()),
        );
      } else {
        showCustomSnackbar(
          message: "Invalid email or password",
          context: context,
        );
      }
    } catch (e) {
      showCustomSnackbar(message: e.toString(), context: context);
    }
  }
}
