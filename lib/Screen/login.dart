import 'package:chatapp/auth/auth_Service.dart';
import 'package:chatapp/components/myBotton.dart';
import 'package:chatapp/components/myTextField.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final void Function()? onPressed;
  Login({super.key, this.onPressed});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  signin(BuildContext context) async {
    AuthService auth = AuthService();
    try {
      await auth.signinWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                e.toString(),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message_rounded,
              size: 85,
            ),
            const SizedBox(
              height: 20,
            ),
            //you have been missed message
            Text(
              "Welcome back ,You have been missed",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 20,
            ),

            //textfield for username and password
            Mytextfield(
                controller: emailController,
                hintText: "Email",
                obsecure: false),
            const SizedBox(
              height: 10,
            ),
            Mytextfield(
                controller: passwordController,
                hintText: "Password",
                obsecure: true),
            //button to login
            const SizedBox(
              height: 15,
            ),
            Mybotton(
              bottonText: "Login",
              onTap: () => signin(context),
            ),
            const SizedBox(
              height: 20,
            ),
            //Text to register page:Not a member ?  Register Now.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Not a Member ?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextButton(
                      onPressed: onPressed,
                      child: Text("Register here",
                          style: TextStyle(
                            color: Colors.blue,
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
