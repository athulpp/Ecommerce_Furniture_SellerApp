import 'package:flutter/material.dart';

class SeachScreen extends StatelessWidget {
  const SeachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffcdc1c1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Enter product name'),
              ),
              Center(
                  child: Text(
                'No Furniture is found',
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ));
  }
}
