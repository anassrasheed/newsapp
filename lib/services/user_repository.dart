// import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/services.dart';
import 'package:news/models/user.dart';
import 'package:news/services/auth_service.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'exceptions/sign_in_out_exception.dart';

class UserRepository implements IAuth<User?, UserParam> {
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;

  @override
  Future<User?> signUp(UserParam? param) {
    switch (param!.signUp) {
      case SignUp.withEmailAndPassword:
        return _createUserWithEmailAndPassword(
          param.email!,
          param.password!,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<User?> signIn(UserParam? param) {
    switch (param!.signIn) {
      case SignIn.anonymously:
        return _signInAnonymously();
      case SignIn.withEmailAndPassword:
        return _signInWithEmailAndPassword(
          param.email!,
          param.password!,
        );

      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut(UserParam? param) async {
    return _firebaseAuth.signOut();
  }

  User _fromFireBaseUserToUser(firebase.User? user) {
    return User(
      uid: user!.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Future<User?> currentUser() async {
    print('entered');
    final firebase.User? firebaseUser = _firebaseAuth.currentUser;
    var user = _fromFireBaseUserToUser(firebaseUser);
    await DatabaseAuthService().addUserData(user);
    return user;
  }

  Future<User?> _signInAnonymously() async {
    try {
      firebase.UserCredential authResult =
          await _firebaseAuth.signInAnonymously();
      return _fromFireBaseUserToUser(authResult.user);
    } catch (e) {
      if (e is PlatformException) {
        throw SignInException(
          title: 'Sign in anonymously',
          code: e.code,
          message: e.message,
        );
      } else {
        rethrow;
      }
    }
  }


  Future<User?> _signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final firebase.UserCredential authResult =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _fromFireBaseUserToUser(authResult.user);
    } catch (e) {
      if (e is firebase.FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            throw EmailException('Email address is not valid');
          case 'user-disabled':
            throw EmailException(
                'User corresponding to the given email has been disabled');
          case 'user-not-found':
            throw EmailException(
                'There is no user corresponding to the given email');
          case 'wrong-password':
            throw PasswordException('Password is invalid for the given email');
          default:
            throw SignInException(
              title: 'Create use with email and password',
              code: e.code,
              message: e.message,
            );
        }
      }
      rethrow;
    }
  }

  Future<User?> _createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      firebase.UserCredential authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _fromFireBaseUserToUser(authResult.user);
    } catch (e) {
      if (e is firebase.FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            throw EmailException('Email address is not valid');
          case 'email-already-in-use':
            throw EmailException(
                'There already exists an account with the given email');
          case 'weak-password':
            throw EmailException(
                'There is no user corresponding to the given email');
          case 'wrong-password':
            throw PasswordException('Password is not strong enough');
          default:
            throw SignInException(
              title: 'Create use with email and password',
              code: e.code,
              message: e.message,
            );
        }
      }
      rethrow;
    }
  }

  @override
  Future<void> init() async {}

  @override
  void dispose() {}
}
