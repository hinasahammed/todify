import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  final TextEditingController controller;
  final String fieldName;
  final String? Function(String?)? validator;
  const CustomTextFormfield(
      {super.key,
      required this.controller,
      required this.fieldName,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        label: Text(fieldName),
      ),
    );
  }
}