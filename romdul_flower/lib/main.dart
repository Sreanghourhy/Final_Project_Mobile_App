import 'package:flutter/material.dart';
import 'package:romdul_flowe/shared/theme.dart';
import 'package:romdul_flowe/screen/Cambodia.dart';


void main(){
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: primaryTheme,
    home: const Home(),
  ));
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sandbox"),
        // backgroundColor: Colors.blue,
      ),
      body: const Text("Sandbox"),
    );
  }
}
