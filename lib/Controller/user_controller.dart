import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/my_user.dart';
//import 'package:flutter_application_1/Views/Auth/forgot_password.dart';
import 'package:flutter_application_1/Views/Auth/login.dart';
import 'package:flutter_application_1/Views/profilies/profile_setup.dart';
import 'package:flutter_application_1/show_custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:uuid/uuid.dart';

class UserController {
  // loin
  void signIn(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomSnackbar(
        message: "Please fill all the fields",
        context: context,
      );
      return;
    }

    try {
      // 1. Sign in with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      // 2. Fetch TempUser data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("ayaztempUser")
          .doc(uid)
          .get();

      if (userDoc.exists) {
        // ✅ Email/Password matched + Data found
        showCustomSnackbar(message: "Login Successful", context: context);

        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const ProfileSetup(), // replace with your dashboard/home
          ),
        );
      } else {
        // ⚠️ Authenticated but no TempUser record found
        showCustomSnackbar(message: "User data not found", context: context);
      }
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else {
        message = e.message ?? "Login failed";
      }
      showCustomSnackbar(message: message, context: context);
    } catch (e) {
      showCustomSnackbar(message: e.toString(), context: context);
    }
  }

  // siup
  static Future<void> signUp(
    String email,
    String password,
    String confirmPass,
    BuildContext context,
  ) async {
    if (email.isEmpty || password.isEmpty || confirmPass.isEmpty) {
      showCustomSnackbar(message: "Please fill all fields", context: context);
      return;
    }
    if (password != confirmPass) {
      showCustomSnackbar(message: "Passwords do not match", context: context);
      return;
    }

    try {
      // Create Firebase Auth user
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;

      // Save extra data in Firestore
      MyUser model = MyUser(
        email: email,
        password: password,
        uid: userId,
        isLoadingStartupData: true,
      );

      await FirebaseFirestore.instance
          .collection("ayaztempUser")
          .doc(userId)
          .set(model.toMap());

      showCustomSnackbar(message: "Sign Up Successful", context: context);

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.fade, child: const LoginPage()),
      );
    } catch (e, stack) {
      print("SignUp Error: $e");
      print(stack);
      // showCustomSnackbar(message: e.toString());
      showCustomSnackbar(message: e.toString(), context: context);
    }
  }
}
