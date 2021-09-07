import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';

class NeumorphicTextFieldContainer extends StatelessWidget {
  final Widget child;

  const NeumorphicTextFieldContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: Constants.appPadding / 2),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Constants.lightPrimary,
                Constants.darkPrimary,
              ]
          ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(-2,-2),
            spreadRadius: 1,
            blurRadius: 4,
            color: Constants.darkShadow,
          ),
          BoxShadow(
            offset: Offset(2,2),
            spreadRadius: 1,
            blurRadius: 4,
            color: Constants.lightShadow,
          ),
        ]
      ),
      child: child,
    );
  }
}
