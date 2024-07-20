import 'package:flutter/material.dart';

import '../../../../core/theme/custom_image_view.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String? icon;
  final bool isActive;

  CustomButton({
    required this.text,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF2C324B) : Color(0xFF2C324B),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: icon == null
            ? Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            : CustomImageView(
                url: icon,
                width: 30,
                height: 30,
              ),
      ),
    );
  }
}
