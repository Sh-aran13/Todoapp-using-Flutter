import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final TextStyle? labelStyle;
  final TextStyle? inputStyle;
  final IconData? prefixIcon;
  final Color? iconColor;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.labelStyle,
    this.inputStyle,
    this.prefixIcon,
    this.iconColor,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: inputStyle,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: iconColor) : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.white.withAlpha(77), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.purpleAccent, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.black.withAlpha(51),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}
