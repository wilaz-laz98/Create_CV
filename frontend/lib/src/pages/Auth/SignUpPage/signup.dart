import 'package:flutter/material.dart';
import 'package:frontend/src/pages/homePage/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:password_strength/password_strength.dart';

import 'package:frontend/src/pages/Auth/LoginPage/login.dart';
import 'package:frontend/src/Utils/utils.dart';
import 'package:frontend/src/theme/app_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';
  String displayText1 = '';
  double _strength = 0;

  Future<void> _signup() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/signup'),
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
        final data = jsonDecode(response.body);
        setState(() {
          _message = data['message'];
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

  void _goToLoginPage() {
    Navigator.of(context).pushReplacement(Utils.createRoute(LoginPage()));
  }

  void _calcStrength(String password) {
    setState(() {
      _strength = estimatePasswordStrength(password);
    });
  }

  @override
  void initState() {
    super.initState();
    Utils.startTyping('Create an Account and join us :)', (updatedText) {
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
                        'Sign Up',
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
                        onChanged: _calcStrength,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password_outlined),
                          hintText: 'Enter your password',
                        ),
                      )),
                  Text(
                      'Password Strength: ${(_strength * 100).toStringAsFixed(2)}%'),
                  LinearProgressIndicator(
                    value: _strength,
                    backgroundColor: Colors.grey[300],
                    color: _strength < 0.3
                        ? Colors.red
                        : _strength < 0.7
                            ? Colors.orange
                            : Colors.green,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                  onPressed: _goToLoginPage,
                                  child: Text(
                                    'Already got an account? login',
                                    style:
                                        AppTheme.darkTheme.textTheme.bodyMedium,
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: _signup, child: Text('Sign UP')),
                            ),
                          ],
                        ),
                      )),
                ],
              ))),
    ));
  }
}
