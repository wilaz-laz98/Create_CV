import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/src/pages/Auth/SignUpPage/signup.dart';
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
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(Utils.createRoute(SignUpPage()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    Utils.startTyping('WELCOME !', (updatedText) {
      setState(() {
        displayText1 = updatedText;
      });
    });
    Timer(Duration(seconds: 4), () {
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
