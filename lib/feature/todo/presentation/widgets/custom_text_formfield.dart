import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  const CustomTextFormfield({
    super.key,
    required this.fieldName,
    required this.controller,
  });
  final String fieldName;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid $fieldName.';
        }
        return null;
      },
      cursorColor: Colors.blue,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(fieldName),
        hintText: fieldName,
      ),
    );
  }
}
