import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constants/constants.dart';
import 'package:news/models/user.dart';
import 'package:news/services/exceptions/sign_in_out_exception.dart';
import 'package:news/utils/helpers/validator.dart';
import 'package:news/utils/ui/widgets/rectangular_button.dart';
import 'package:news/utils/ui/widgets/rectangular_input_field.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../injected.dart';

final _email = RM.injectTextEditing(
  validator: (String? val) {
    if (!Validators.isValidEmail(val!)) {
      return 'Enter a valid email';
    }
  },
);
final _password = RM.injectTextEditing(
  // validator: (String? val) {
  //   if (!Validators.isValidPassword(val!)) {
  //     return 'Enter a valid password';
  //   }
  // },
  validateOnTyping: false,
);
final _form = RM.injectForm();

class Credentials extends StatelessWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return On(() {
      return Padding(
        padding: EdgeInsets.all(Constants.appPadding),
        child: On.form(
          ()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RectangularInputField(
                hintText: 'Email',
                icon: Icons.email_rounded,
                obscureText: false,
                injectedTextEditing: _email,
              ),
              SizedBox(
                height: Constants.appPadding / 2,
              ),
              RectangularInputField(
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                injectedTextEditing: _password,
                onSubmitted: (_){
                  _form.submitFocusNode.requestFocus();
                },
              ),
              SizedBox(
                height: Constants.appPadding / 2,
              ),
              Center(
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Constants.defaultTextColor.withOpacity(0.8),
                  ),
                ),
              ),
              On.formSubmission(
                onSubmitting: () =>
                    Center(child: CircularProgressIndicator()),
                child: RectangularButton(
                    text: 'Sign In',
                    press: ()  {
                      _form.submit(
                            () async {
                            await user.auth.signIn(
                                  (_) => UserParam(
                                signIn: SignIn.withEmailAndPassword,
                                email: _email.state,
                                password: _password.state,
                              ),
                            );
                            //Server validation
                            if (user.error is EmailException) {
                              _email.error = user.error.message;
                            }
                            if (user.error is PasswordException) {
                              _password.error = user.error.message;
                            }
                        },
                      );
                    }),
              ).listenTo(_form),

            ],
          )).listenTo(_form),
      );
    }).listenTo(user);
  }
}
