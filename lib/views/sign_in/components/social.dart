import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';
import 'package:news/utils/ui/widgets/account_check.dart';
import 'package:news/views/sign_up/sigup_screen.dart';

class Social extends StatelessWidget {
  const Social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'OR',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Constants.defaultTextColor.withOpacity(0.7),
          ),
        ),

        SizedBox(
          height: Constants.appPadding,
        ),
        AccountCheck(
          login: true,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
