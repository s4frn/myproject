import 'package:flutter/material.dart';
import 'package:myproject/custom_scaffold.dart';
import 'package:myproject/signin_screen.dart';
import 'package:myproject/signup_screen.dart';
import 'package:myproject/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Column(
          children: [
            Flexible(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 40.0,
                  ),
                  child: Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Welcome Back!\n',
                                    style: TextStyle(
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text:
                                    '\nEnter your details to your employee account',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))
                              ]
                          ))),
                )),
            Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      const Expanded(
                          child: WelcomeButton(
                            buttonText: 'Sign in',
                            onTap: SignInScreen(),
                            color: Colors.transparent,
                            textColor: Colors.white,
                          )
                      ),
                      Expanded(
                          child: WelcomeButton(
                            buttonText: 'Sign up',
                            onTap: SignUpScreen(),
                            color: Colors.white,
                            textColor: Colors.green,
                          )
                      ),

                    ],
                  ),
                )
            ),
          ],
        )
    );
  }
}
