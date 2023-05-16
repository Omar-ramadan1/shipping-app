import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TitleOfDraw extends StatelessWidget {
  final String title;
  final VoidCallback function;
  TitleOfDraw(this.title, this.function);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: InkWell(
            onTap: () {
              function();
            },
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.5,
          endIndent: 20,
          indent: 20,
          color: Colors.white,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
