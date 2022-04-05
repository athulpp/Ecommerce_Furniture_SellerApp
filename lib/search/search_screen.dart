import 'package:flutter/material.dart';

class SeachScreen extends StatelessWidget {
  const SeachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
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
              Container(
                height: 400,
                child: Center(
                    child: Text(
                  'No Furniture is found',
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
        ));
  }
}
