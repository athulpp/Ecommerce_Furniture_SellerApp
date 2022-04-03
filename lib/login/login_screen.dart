import 'package:flutter/material.dart';

import '../const/constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              height40,
              Text('Log In Seller'),
              Center(child: Image.asset('assests/images/icon (2).png')),

            ],
          ),
        ),
      ),
    );
  }
}
