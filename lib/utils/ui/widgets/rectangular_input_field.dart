import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';

import 'neumorphic_text_field_container.dart';

class RectangularInputField extends StatelessWidget {

  final String hintText;
  final IconData icon;
  final bool obscureText;

  const RectangularInputField({Key? key, required this.hintText, required this.icon, required this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTextFieldContainer(
      child: TextField(
        cursorColor: defaultTextColor,
        obscureText: obscureText,
        style: TextStyle(
          color: defaultTextColor,
          fontSize: 18,

        ) ,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:TextStyle(
            color: defaultTextColor.withOpacity(0.7),
            fontSize: 18,

          ) ,
          helperStyle: TextStyle(
            color: defaultTextColor,
            fontSize: 18,

          ),
          prefixIcon: Icon(icon,color: defaultTextColor.withOpacity(0.7),size: 20,),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
