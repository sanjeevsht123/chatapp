import 'package:chatapp/Screen/home.dart';
import 'package:chatapp/services/auth/auth_Service.dart';
import 'package:chatapp/services/auth/loginorregister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authgate extends StatelessWidget {
  Authgate({super.key});
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.hasData) {
            return Home();
          } else {
            return Loginorregister();
          }
        });
  }
}
