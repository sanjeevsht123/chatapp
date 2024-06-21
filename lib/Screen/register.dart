import 'package:chatapp/services/auth/auth_Service.dart';
import 'package:chatapp/components/myBotton.dart';
import 'package:chatapp/components/myTextField.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final void Function()? onTap;
  Register({super.key, this.onTap});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  signup(BuildContext context) async {
    AuthService auth = AuthService();
    try {
      if (passwordController.text == confirmController.text) {
        await auth.signupWithEmailandPassword(
            emailController.text, passwordController.text);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("password not matched !!"),
              );
            });
      }
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
              "Let's create account for you",
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
            Mytextfield(
                controller: confirmController,
                hintText: "conform Password",
                obsecure: true),
            //button to login
            const SizedBox(
              height: 15,
            ),
            Mybotton(
              bottonText: "Sign up",
              onTap: () => signup(context),
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
                    "Already have an account ?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextButton(
                      onPressed: onTap,
                      child: Text("Login",
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
