import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/splash_loader_animation.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_application_1/Views/Auth/Features/Album/album_post.dart';
//import 'package:flutter_application_1/Views/Auth/register.dart';
// import 'package:flutter_application_1/Views/Widgets/Auth/splash_loader_animation.dart';
//import 'package:flutter_application_1/all_screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // <- required before using Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      // home: AlbumPost(),
      home: SplashLoaderAnimation(),
    );
  }
}
