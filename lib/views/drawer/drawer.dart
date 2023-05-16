import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/views/drawer/widgetOfDrawer/TitleOfRow.dart';
import 'package:shopapp/views/resetPassworld/resetPassworld_screen.dart';
import 'package:shopapp/views/signup/signup_screen.dart';

import '../../controller/user_data.dart';
import '../../constant/colors.dart';
import '../../models/userdata_moder.dart';
import '../../plugins/Dependentplugins.dart';
import '../getCustomer/getCustomer_screen.dart';
import '../getOrders/getOrder_screen.dart';
class Drawer_Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.mainAppColor,
      child: SingleChildScrollView(
        child: Container(
          color: AppColor.mainAppColor,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: double.maxFinite,
                    //      color: Color(0xFFBD954F),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        //       color: Color(0xFFBD954F),
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 7,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: AppColor.grey,
                          size: 105,
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
  future: context.read<UserData>().getprofile(context),
  builder: (context, snapshot) {
     if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              }
                print(snapshot.data);
            
    if (snapshot.hasData) {
      return Text("user.jsonrpc.toString()");
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }
    return CircularProgressIndicator();
  },
)
                ],
              ),
              
              TitleOfDraw("Customer", () {
                navigateTo(context, GetCustomerScreen());
              }),

                TitleOfDraw("Orders", () {
                navigateTo(context, GetOrderScreen());
              }),
                TitleOfDraw("Reset Password", () {
                navigateTo(context, ResetPassworldScreen());
              }),
              
             
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () {
                        alertDialog(
                          context,
                          "Will you logout",
                          MaterialButton(
                            onPressed: () {
                              navigateWithoutBack(context, SignUpScreen());
                            },
                            child: Text("YES"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("NO"),
                          ),
                        );
                      },
                      child: Text("Logout",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            //fontWeight: FontWeight.bold
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
