import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../plugins/Dependentplugins.dart';
import '../../signup/signup_screen.dart';

class SubTitle_Widget extends StatelessWidget {
  final String upperTitle;
  final String subTitle;
  final VoidCallback voidCallback;
  SubTitle_Widget(this.upperTitle, this.subTitle, this.voidCallback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(upperTitle),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  voidCallback();
                },
                child: Text(subTitle,style: TextStyle(fontWeight: FontWeight.bold),)),
          ],
        ),
      ],
    );
  }
}
