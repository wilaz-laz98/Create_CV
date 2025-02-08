import 'dart:async';

import 'package:flutter/material.dart';

class Utils {
  static Route createRoute(page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 1500),
    );
  }

  static void startTyping(String text, Function(String) onUpdate,
      {int speed = 200}) {
    int index = 0;
    Timer.periodic(Duration(milliseconds: speed), (Timer timer) {
      if (index < text.length) {
        onUpdate(text.substring(0, index + 1));
        index++;
      } else {
        timer.cancel();
      }
    });
  }
}
