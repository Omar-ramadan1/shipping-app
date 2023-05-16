import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Body_Widget extends StatelessWidget {
  const Body_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 4,
                child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn,
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/mainimage.png"),
                          )),
                        ),
                //  Icon(
                //   Icons.local_shipping,
                //   size: 170,
                //   color: Color(0xFF0197A5),
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
