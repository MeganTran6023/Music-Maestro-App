import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onTap; // Optional tap handler

  const CircleWidget({
    Key? key,
    required this.isActive,
    this.onTap, // Can be null if no interaction is needed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // onTap will be null in InstructionsPage, allowing no interaction
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? const Color.fromARGB(255, 231, 28, 140) : Colors.grey, // Active: green, Inactive: grey
        ),
      ),
    );
  }
}
