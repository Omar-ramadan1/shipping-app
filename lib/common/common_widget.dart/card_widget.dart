import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constant/colors.dart';


class Card_widget extends StatelessWidget {
  // final IconData iconData;
  final String title;
  final String titleTwo;
  final VoidCallback voidCallback;
  final String? costOfProduct;
  final bool internet;
  //final File file;
  Card_widget(
    //this.iconData,
    this.title,
    this.titleTwo,
    this.voidCallback,
        this.internet,

     {
    this.costOfProduct = "",
  }
      // this.file

      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Container(
        height: MediaQuery.of(context).size.height / 8,
        child: InkWell(
          onTap: () {
            voidCallback();
          },
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                internet?
                Image.network(
                  //    "${Urls.image}/web/image?model=res.partner&id=35&field=avatar_128&unique=02102023020429",
                  "http://62.171.157.28:8011/web/static/src/img/placeholder.png",
                  fit: BoxFit.cover,
                ) :
                Icon(Icons.camera_alt,size: 90,color: AppColor.grey,),
//Image.file(image!, width: 50, height: 50, fit: BoxFit.cover)
                // Icon(
                //   iconData,
                //   color: AppColor.grey,
                //   size: 100,
                // ),
                // Image.network(
                //   "https://t3.ftcdn.net/jpg/01/65/63/94/360_F_165639425_kRh61s497pV7IOPAjwjme1btB8ICkV0L.jpg",
                //   height: 240,
                //   //width: 200,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 5),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 5),
                        child: Text(
                          titleTwo,
                          style: TextStyle(color: AppColor.mainAppColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 5),
                        child: Text(
                          costOfProduct!.toString(),
                          style: TextStyle(color: AppColor.mainAppColor),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
