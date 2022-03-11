import 'package:flutter/material.dart';

class AppInputWidget extends StatelessWidget {
  const AppInputWidget({
    Key? key,
    required this.controller,
    this.contentPaddingHorizontal = 16,
    this.contentPaddingVertical = 0,
    this.labelText,
    this.hintText,
    this.padding,
    this.validator,
    this.maxLength,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final bool obscureText;
  final EdgeInsets? padding;
  final String? labelText;
  final String? hintText;
  final Function? validator;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (val) => validator != null ? validator!(val) : null,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingHorizontal,
            vertical: contentPaddingVertical,
          ),
          counterText: "",
          labelText: labelText,
          hintText: hintText,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.blue),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Color.fromARGB(255, 197, 224, 246),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
