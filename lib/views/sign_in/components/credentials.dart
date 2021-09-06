import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';
import 'package:news/utils/ui/widgets/rectangular_button.dart';
import 'package:news/utils/ui/widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RectangularInputField(
            hintText: 'Email',
            icon: Icons.email_rounded,
            obscureText: false,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          RectangularInputField(
            hintText: 'Password',
            icon: Icons.lock,
            obscureText: true,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          Center(
            child: Text(
              'Forget Password?',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: defaultTextColor.withOpacity(0.8),
              ),
            ),
          ),
          RectangularButton(text: 'Sign In', press: () {})
        ],
      ),
    );
  }
}
