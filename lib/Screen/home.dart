import 'package:chatapp/auth/auth_Service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  AuthService auth = AuthService();
  logout(BuildContext context) async {
    try {
      await auth.logout();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: Icon(Icons.exit_to_app_outlined),
          )
        ],
      ),
    );
  }
}
