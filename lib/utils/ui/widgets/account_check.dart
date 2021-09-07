import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';

class AccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  const AccountCheck({Key? key, required this.login, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an Account?" : "Already have an Account?",
          style: TextStyle(
            fontSize: 16,
            color: Constants.defaultTextColor.withOpacity(0.7),
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Constants.defaultTextColor.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}
