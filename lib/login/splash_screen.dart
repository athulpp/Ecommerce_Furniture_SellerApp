import 'package:flutter/material.dart';
import 'package:seller/login/hometo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeTo(),
          ),
          (route) => false);
    });
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assests/images/Group.png'),
          const Text(
            'Furnidesk ',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey),
          )
        ],
      )),
    );
  }
}
