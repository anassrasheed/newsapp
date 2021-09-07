import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';

class HeadText extends StatelessWidget {
  const HeadText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: Constants.appPadding,
        vertical: Constants.appPadding / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.05),
          Text('Welcome',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
              color: Constants.defaultTextColor

          ),),
          Text('SIGN IN',style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Constants.defaultTextColor
          ),),
        ],
      ),
    );
  }
}
