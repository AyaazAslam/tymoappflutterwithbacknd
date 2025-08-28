import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color iconColor;
  final double borderRadius;
  final IconData leadingIcon;

  const SimpleButton({
    super.key,
    required this.text,
    required this.color,
    required this.iconColor,
    required this.borderRadius,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: height * 0.065,
        width: width * 0.4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FittedBox(
          child: Row(
            children: [
              Icon(leadingIcon, color: iconColor),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
