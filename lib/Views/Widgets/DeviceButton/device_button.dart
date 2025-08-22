import 'package:flutter/material.dart';

class DeviceButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double width;
  const DeviceButtonWidget({super.key, 
    required this.color,
    required this.text,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
