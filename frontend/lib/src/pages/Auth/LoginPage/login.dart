import 'package:flutter/material.dart';
import 'package:frontend/src/pages/Auth/SignUpPage/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/Shared_preferences.dart';

import 'package:frontend/src/Utils/utils.dart';
import 'package:frontend/src/theme/app_theme.dart';
import 'package:frontend/src/pages/homePage/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';
  String displayText1 = '';

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    try {
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        final accessToken = jsonDecode(response.body)['token'];
        prefs.setString('email', _emailController.text);
        prefs.setString('access_token', accessToken);
        setState(() {
          _message = 'login successful !)';
          Navigator.of(context).pushReplacement(Utils.createRoute(HomePage()));
        });
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
        ));
      }
    } catch (e) {
      print('Error parsing JSON: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid response from server'),
      ));
    }
  }

  void _goToSignupPage() {
    Navigator.of(context).pushReplacement(Utils.createRoute(SignUpPage()));
  }

  @override
  void initState() {
    super.initState();
    // _checklogin();
    Utils.startTyping('Welcome, please Login !)', (updatedText) {
      setState(() {
        displayText1 = updatedText;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
              border: Border.all(
            color: AppTheme.secondarydark,
            width: 1,
          )),
          child: SizedBox(
              height: 300,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'Login',
                        style: AppTheme.darkTheme.textTheme.headlineMedium,
                      )),
                  Expanded(
                      flex: 2,
                      child: _message.isNotEmpty
                          ? Text(
                              _message,
                              style: TextStyle(color: Colors.green),
                            )
                          : Text(
                              displayText1,
                              style: AppTheme.darkTheme.textTheme.bodyLarge,
                            )),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: 'Enter your email'),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password_outlined),
                          hintText: 'Enter your password',
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                  onPressed: _goToSignupPage,
                                  child: Text(
                                    "Don't have an account? Signup",
                                    style:
                                        AppTheme.darkTheme.textTheme.bodyMedium,
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: _login, child: Text('Login')),
                            ),
                          ],
                        ),
                      )),
                ],
              ))),
    ));
  }
}
