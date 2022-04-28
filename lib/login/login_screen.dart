import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:seller/home/home_screen.dart';

import '../const/constant.dart';
import '../const/custom_button.dart';
import '../control/bottom_navigation.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  String? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                height40,
                Text(
                  'Log In Seller',
                  style: mainHeading,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset(
                    'assests/images/icon (2).png',
                    color: Colors.brown,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Enter your email and password below',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('Please Enter Email');
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("please Enter valid email");
                            }
                            return null;
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                              // fillColor: Colors.grey,
                              filled: true,
                              labelText: 'Email address',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.brown,
                              )),
                        ),
                      ),
                      height10,
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                            validator: ((value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                            }),
                            onSaved: (value) {
                              _passwordController.text = value!;
                            },
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                              // fillColor: Colors.grey,
                              filled: true,
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.brown,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                height10,
                CustomButton(
                  onPressed: () {
                    signIn(context, _emailController.text,
                        _passwordController.text);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => BottomNavigation()));

                    // Get.to(() => HomeScreen());
                  },
                  text: 'Log In',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn(context, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      {
        try {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomNavigation()));
          print(userCredential.user?.uid);
          await storage.write(key: "uid", value: userCredential.user?.uid);
        } on FirebaseAuthException catch (error) {
          Fluttertoast.showToast(
              msg: error.message.toString(), gravity: ToastGravity.TOP);
        }
      }
    }
  }
}
