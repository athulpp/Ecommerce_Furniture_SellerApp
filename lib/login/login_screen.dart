import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../const/constant.dart';
import '../const/custom_button.dart';
import '../control/bottom_navigation.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
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
                const Text(
                  'Log In Seller',
                  style: mainHeading,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset(
                    'assests/images/icon (2).png',
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Enter your email and password below',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
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
                            if (value != 'seller@gmail.com') {
                              return ('Please enter correct EmailId');
                            }
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
                              RegExp regex = RegExp(r'^.{6,}$');

                              if (value != '123456') {
                                return ("Please enter correct password");
                              }
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                              return null;
                            }),
                            onSaved: (value) {
                              _passwordController.text = value!;
                            },
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
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
      
          await storage.write(key: "uid", value: userCredential.user?.uid);
        } on FirebaseAuthException catch (error) {
          Fluttertoast.showToast(
              msg: error.message.toString(), gravity: ToastGravity.TOP);
        }
      }
    }
  }
}
