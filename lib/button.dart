import 'package:flutter/material.dart';

class ButtonCLick extends StatelessWidget {
  final color;
  final textColor;
  final String butText;
  final buttonTap;

  ButtonCLick({this.color, this.textColor, this.butText, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                butText,
                style: TextStyle(color: textColor, fontSize: 28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
