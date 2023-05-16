import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shopapp/constant/colors.dart';

class TitleOfPage extends StatelessWidget {
  final String title;
  TitleOfPage(this.title);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
         title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color:AppColor.mainAppColor ),
        )
      ],
    );
  }
}
