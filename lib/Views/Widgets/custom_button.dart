import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;

  final Color color;
 
  final IconData leadingIcon;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.color,
    
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(leadingIcon, color: Colors.black),
                  const SizedBox(width: 2),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
