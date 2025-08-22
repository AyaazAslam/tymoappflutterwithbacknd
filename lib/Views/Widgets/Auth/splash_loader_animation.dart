import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_application_1/Views/Auth/register.dart';

class SplashLoaderAnimation extends StatefulWidget {
  const SplashLoaderAnimation({super.key});

  @override
  State<SplashLoaderAnimation> createState() => _SplashLoaderAnimationState();
}

class _SplashLoaderAnimationState extends State<SplashLoaderAnimation> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return; // avoid navigation after widget dispose
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterPage()),
      );
    });
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
