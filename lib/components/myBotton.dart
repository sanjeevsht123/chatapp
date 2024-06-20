import 'package:flutter/material.dart';

class Mybotton extends StatelessWidget {
  final String bottonText;
  final void Function()? onTap;
  const Mybotton({super.key, required this.bottonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            bottonText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}
