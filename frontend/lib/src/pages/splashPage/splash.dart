import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/Shared_preferences.dart';

import 'package:frontend/src/pages/Auth/SignUpPage/signup.dart';
import 'package:frontend/src/pages/homePage/home.dart';
import 'package:frontend/src/theme/app_theme.dart';
import 'package:frontend/src/Utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String displayText1 = '';
  String displayText2 = '';

  void startTimer() {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(Utils.createRoute(SignUpPage()));
    });
  }

  Future<void> _checklogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/protected'),
        headers: {'Autorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        setState(() {
          print('user is logged in, Welcome back !)');
          Navigator.of(context).pushReplacement(Utils.createRoute(HomePage()));
        });
      } else {
        print('user is not logged in, please login !)');
      }
    } else {
      print('no token found');
    }
  }

  @override
  void initState() {
    super.initState();
    _checklogin();
    startTimer();
    Utils.startTyping('WELCOME !', (updatedText) {
      setState(() {
        displayText1 = updatedText;
      });
    });
    Timer(Duration(seconds: 2), () {
      Utils.startTyping('Ready to Create your CV?', (updatedText) {
        setState(() {
          displayText2 = updatedText;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo_dark.png'),
            Text(displayText1,
                style: AppTheme.darkTheme.textTheme.headlineLarge),
            Text(displayText2, style: AppTheme.darkTheme.textTheme.bodyLarge),
            RefreshProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
