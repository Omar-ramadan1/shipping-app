import 'package:flutter/material.dart';

import '../../../constant/colors.dart';

class Funcations {
  String xx = "here is the terms and conditions";
  showmode(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        backgroundColor: AppColor.white,
        isScrollControlled: true,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: AppColor.mainAppColor),
                ),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      child: Text(
                        xx,
                        style: TextStyle(fontSize: 24),
                      ),
                    )),
              ),
              SizedBox(
                height: 1500,
              )
            ],
          );
        });
  }
}
