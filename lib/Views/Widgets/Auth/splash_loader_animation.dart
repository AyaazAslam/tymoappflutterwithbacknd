import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Auth/login.dart';
import 'package:flutter_application_1/Views/navbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashLoaderAnimation extends StatefulWidget {
  const SplashLoaderAnimation({super.key});

  @override
  State<SplashLoaderAnimation> createState() => _SplashLoaderAnimationState();
}

class _SplashLoaderAnimationState extends State<SplashLoaderAnimation> {
  @override
  void initState() {
    super.initState();
    _routeNext();
  }

  Future<void> _routeNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('session_uid') ?? '';
    if (!mounted) return;
    if (uid.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NavBarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // prevents flicker
      body: Center(
        child: LoadingAnimationWidget.halfTriangleDot(
          color: const Color(0xff1552B1),
          size: 50,
        ),
      ),
    );
  }
}
