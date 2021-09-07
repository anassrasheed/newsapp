import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news/models/user.dart';
import 'package:news/services/exceptions/exception_handler.dart';
import 'package:news/services/exceptions/sign_in_out_exception.dart';
import 'package:news/services/user_repository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

enum Env { dev, prod }
Env currentEnv = Env.dev;

final InjectedAuth<User?, UserParam> user = RM.injectAuth<User?, UserParam>(
      () {
    initApp();
    return {
      Env.dev: () => UserRepository(
        // exception: PasswordException('Invalid password'),
      ),
      Env.prod: () => UserRepository(),
    }[currentEnv]!();
  },
  onAuthStream: (repo) => (repo as UserRepository).currentUser().asStream(),
  onSetState: On.error(
        (err, refresh) {
      if (err is EmailException || err is PasswordException) {
        return;
      }
      RM.navigate.to(
        AlertDialog(
          title: Text(ExceptionsHandler.errorMessage(err).title!),
          content: Text(ExceptionsHandler.errorMessage(err).message!),
        ),
      );
    },
  ),
);

void initApp(){
  print('app Initialized');
  Firebase.initializeApp();
}

