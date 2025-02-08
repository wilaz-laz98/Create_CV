import 'package:flutter/material.dart';
import 'package:frontend/src/Utils/utils.dart';
import 'package:frontend/src/theme/app_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String displayText1 = '';

  @override
  void initState() {
    super.initState();
    Utils.startTyping('Create an Account and join us :)', (updatedText){
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
                  color: AppTheme.primarydark,
                  width: 1,
                )
              ),
              child:SizedBox(
              height: 200,
              width: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Sign Up', style: AppTheme.darkTheme.textTheme.headlineMedium,)
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(displayText1, style: AppTheme.darkTheme.textTheme.bodyLarge,)
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child:TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter your password, 12 characters, 1Cap, 1Special, 1num ',
                        ),
                      )
                    ),
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: ,
                    //     child: Text('Sign UP')
                    //   )
                    // )
                  ],
                )
            )
            ),
        )
        );
  }
}
