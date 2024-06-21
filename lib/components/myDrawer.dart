import 'package:chatapp/Screen/setting.dart';
import 'package:chatapp/services/auth/auth_Service.dart';
import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  Mydrawer({super.key});
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
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.message,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  onTap: () => Navigator.of(context).pop(),
                  leading: Icon(Icons.home),
                  title: Text("H O M E"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Setting()));
                    Navigator.of(context).pop();
                  },
                  leading: Icon(Icons.settings),
                  title: Text("S E T T I N G"),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 20),
            child: ListTile(
              onTap: () => logout(context),
              leading: Icon(Icons.exit_to_app),
              title: Text("L O G O U T"),
            ),
          )
        ],
      ),
    );
  }
}
