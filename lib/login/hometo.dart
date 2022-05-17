import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seller/control/bottom_navigation.dart';
import 'package:seller/login/login_screen.dart';


class HomeTo extends StatelessWidget {
  const HomeTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BottomNavigation(
                currentIndex: 0,
              );
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}
