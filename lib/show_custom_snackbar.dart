import 'package:flutter/material.dart';

void showCustomSnackbar({
  required String message,
  required BuildContext context,
  Color backgroundColor = const Color(0xFF1E1E2C), // VIP dark background
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3),
}) {
  final messenger = ScaffoldMessenger.of(context);

  messenger.clearSnackBars(); // remove old ones before showing a new one

  messenger.showSnackBar(
    SnackBar(
      content: Row(
        children: [
          // Animated Icon Glow
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 28,
                ),
              );
            },
          ),
          const SizedBox(width: 12),

          // Fade-in Text
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: duration,
      elevation: 8,
    ),
  );
}
