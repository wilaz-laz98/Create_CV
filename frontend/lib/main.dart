import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // // // get the screen size
  // final screen = WidgetsBinding.instance.platformDispatcher.views.first;
  // final screenwidth = screen.physicalSize.width / screen.devicePixelRatio;
  // final screenheight = screen.physicalSize.height / screen.devicePixelRatio;

  // // calculate desired position
  // final double windowwidth = 550;
  // final double windowheight = 350;
  // final positionx = (screenwidth - windowwidth) ;//TODO: change this later, to the center or the left
  // final positiony = (screenheight - windowheight) / 2;

  // setWindowTitle("Create CV");
  // setWindowMinSize(Size(windowwidth, windowheight));
  // setWindowMaxSize(Size(windowwidth, windowheight));
  // setWindowFrame(
  //     Rect.fromLTWH(positionx, positiony, windowwidth, windowheight));

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(CreateCv());
}
