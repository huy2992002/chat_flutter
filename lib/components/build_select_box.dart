import 'package:flutter/material.dart';

class BuildSelectBox extends StatelessWidget {
  const BuildSelectBox({
    super.key,
    this.onPressed,
    required this.text,
    required this.icon,
  });
  final VoidCallback? onPressed;
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            icon
          ],
        ),
      ),
    );
  }
}