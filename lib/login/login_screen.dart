import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller/home/home_screen.dart';

import '../const/constant.dart';
import '../const/custom_button.dart';
import '../control/bottom_navigation.dart';

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
              Text(
                'Log In Seller',
                style: mainHeading,
              ),
              height10,
              Center(
                child: Image.asset('assests/images/icon (2).png'),
              ),
              height10,
              Text('Enter your email and password below'),
              height10,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Email address'),
                ),
              ),
              height10,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Password'),
                ),
              ),
              height10,
              CustomButton(
                onPressed: () {
                  Get.to(() => BottomNavigation());
                  // Get.to(() => HomeScreen());
                },
                text: 'Log In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
