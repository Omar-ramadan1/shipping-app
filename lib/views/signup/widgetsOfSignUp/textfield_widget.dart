import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextField_Widget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? fieldValidator;

  TextField_Widget(this.hint, this.controller, this.fieldValidator);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: TextFormField(
        validator: fieldValidator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          //  fillColor: Colors.green
        ),
      ),
    );
  }
}
