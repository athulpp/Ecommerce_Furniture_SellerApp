import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:seller/control/bottom_navigation.dart';
// import 'package:seller/control/bottom_navigation.dart';
// import 'package:seller/home/home_screen.dart';

import 'package:seller/login/login_screen.dart';
import 'package:seller/theme/theme.dart';
import 'package:seller/theme/theme_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

ThemeManger _themeManger = ThemeManger();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final storage = new FlutterSecureStorage();
  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: Theme.of(context).f,
      theme: ThemeData(primarySwatch: Colors.brown),
      home: FutureBuilder(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == false) {
            return LoginScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return BottomNavigation();
        },
      ),
    );
  }
}
