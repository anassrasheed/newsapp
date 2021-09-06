import 'package:flutter/material.dart';
import 'package:news/views/home/home_screen.dart';
import 'package:news/views/sign_in/sigin_screen.dart';
import 'package:news/views/splash/splash_screen.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'injected.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TopAppWidget(
      ensureInitialization: () => [
      ],
      onWaiting: () => MaterialApp(
        home: SplashScreen(),
      ),
      builder: (_) => MaterialApp(
        home: On.auth(
          onInitialWaiting: () => SplashScreen(),
          onUnsigned: () => SignInScreen(),
          onSigned: () => HomeScreen(),
        ).listenTo(
          user,
          useRouteNavigation: true,
        ),
        navigatorKey: RM.navigate.navigatorKey,
      ),
    );
  }
}
