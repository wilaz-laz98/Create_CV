import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class CreateCv extends StatelessWidget {
  const CreateCv({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CreateCv App',
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}
