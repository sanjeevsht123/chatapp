import 'package:chatapp/Screen/login.dart';
import 'package:chatapp/Screen/register.dart';
import 'package:flutter/material.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  //initially show login page
  bool showLoginpage = true;

  //toggle function
  void togglePage() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return Login(
        onPressed: togglePage,
      );
    } else {
      return Register(
        onTap: togglePage,
      );
    }
  }
}
