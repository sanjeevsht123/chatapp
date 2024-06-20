import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecure;
  const Mytextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obsecure,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
