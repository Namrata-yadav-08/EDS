import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          minimumSize: WidgetStatePropertyAll(Size(
            320,
            50,
          ))),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 19,
          color: Colors.white,
        ),
      ),
    );
  }
}
