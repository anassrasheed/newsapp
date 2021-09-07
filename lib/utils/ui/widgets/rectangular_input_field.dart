import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/constants/constants.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'neumorphic_text_field_container.dart';

class RectangularInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final InjectedTextEditing? injectedTextEditing;
  final ValueChanged<String>? onSubmitted;

  const RectangularInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.obscureText,
      this.injectedTextEditing,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTextFieldContainer(
      child: injectedTextEditing == null
          ? TextField(
              cursorColor: Constants.defaultTextColor,
              obscureText: obscureText,
              style: TextStyle(
                color: Constants.defaultTextColor,
                fontSize: 18,
              ),
              onSubmitted: (_) {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Constants.defaultTextColor.withOpacity(0.7),
                  fontSize: 18,
                ),
                helperStyle: TextStyle(
                  color: Constants.defaultTextColor,
                  fontSize: 18,
                ),
                prefixIcon: Icon(
                  icon,
                  color: Constants.defaultTextColor.withOpacity(0.7),
                  size: 20,
                ),
                border: InputBorder.none,
              ),
            )
          : TextField(
              cursorColor: Constants.defaultTextColor,
              controller: injectedTextEditing!.controller,
              focusNode: injectedTextEditing!.focusNode,
              obscureText: obscureText,
              onSubmitted: (v) {
                injectedTextEditing!.focusNode.requestFocus();
                if (onSubmitted != null) onSubmitted!.call(v);
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              style: TextStyle(
                color: Constants.defaultTextColor,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                errorText: injectedTextEditing!.error,
                hintStyle: TextStyle(
                  color: Constants.defaultTextColor.withOpacity(0.7),
                  fontSize: 18,
                ),
                helperStyle: TextStyle(
                  color: Constants.defaultTextColor,
                  fontSize: 18,
                ),
                prefixIcon: Icon(
                  icon,
                  color: Constants.defaultTextColor.withOpacity(0.7),
                  size: 20,
                ),
                border: InputBorder.none,
              ),
            ),
    );
  }
}
