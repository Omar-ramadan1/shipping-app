import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextFieldPass_Widget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? fieldValidator;
  final bool nonsecure;
  final VoidCallback setState;

  TextFieldPass_Widget(this.hint, this.controller, this.fieldValidator,
      this.nonsecure, this.setState);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: TextFormField(
        obscureText: nonsecure,
        validator: fieldValidator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffixIcon: nonsecure
              ? InkWell(
                  onTap: () {
                    setState();
                  },
                  child: Icon(
                    Icons.visibility_off_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              : InkWell(
                  onTap: () {
                    setState();
                  },
                  child: Icon(
                    Icons.visibility,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
          filled: true,
          //  fillColor: Colors.green
        ),
      ),
    );
  }
}
