import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';
import 'package:news/utils/ui/widgets/account_check.dart';
import 'package:news/views/sign_in/sigin_screen.dart';

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
            color: defaultTextColor.withOpacity(0.7),
          ),
        ),
        SizedBox(
          height: appPadding,
        ),
        AccountCheck(
          login: false,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignInScreen();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
