import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: Theme.of(context).colorScheme.inversePrimary,
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
      child: Text(text),
    );
  }
}