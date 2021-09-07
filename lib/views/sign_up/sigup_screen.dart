import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';

import 'components/credentials.dart';
import 'components/head_text.dart';
import 'components/social.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Constants.lightPrimary,
            Constants.darkPrimary,
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadText(),
              Credentials(),
              Social(),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
