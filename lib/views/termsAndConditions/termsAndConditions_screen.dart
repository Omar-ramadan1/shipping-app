import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shopapp/constant/colors.dart';

class TermsAndCondition extends StatelessWidget {
  static const routename = '/TermsAndConditons';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: AppColor.mainAppColor),
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 40 , left: 10 , right: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text("" ,
          style: TextStyle(
            fontWeight: FontWeight.w700,
                fontSize: 20,
          ),),
        ),
      ),
    );
  }
}