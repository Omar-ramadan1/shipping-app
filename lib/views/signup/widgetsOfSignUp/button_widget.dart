import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shopapp/constant/colors.dart';

class Button_widget extends StatelessWidget {
  final String text;
  final VoidCallback voidCallback;
  Button_widget(this.text, this.voidCallback);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColor.mainAppColor),
      child: MaterialButton(
        onPressed: () {
          voidCallback();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
