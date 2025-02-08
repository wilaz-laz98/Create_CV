import 'package:flutter/material.dart';
import 'package:frontend/src/pages/Auth/LoginPage/login.dart';
import 'package:frontend/src/pages/Auth/SignUpPage/signup.dart';
import 'package:frontend/src/pages/splashPage/splash.dart';



class AppRoutes {
  static const String initial = '/';
  static const String spalsh = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => SplashPage(),
    login: (context) => LoginPage(),
    register: (context) => SignUpPage(),
    // home: (context) => HomePage(),
    // profile: (context) => ProfilePage(),
  };

}
