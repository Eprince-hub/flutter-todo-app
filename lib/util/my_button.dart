import 'package:flutter/material.dart';
import 'package:flutter_todo_app/util/my_text.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: MyText(text: buttonText),
    );
  }
}
