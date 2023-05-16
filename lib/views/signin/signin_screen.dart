import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopapp/common/appDecor.dart';
import 'package:shopapp/constant/strings.dart';
import 'package:shopapp/plugins/Dependentplugins.dart';
import 'package:shopapp/views/createOrder/CreateOrder_screen.dart';
import 'package:shopapp/views/getCustomer/getCustomer_screen.dart';
import 'package:shopapp/views/signup/signup_screen.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/button_widget.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/textfield_widget.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/titleOfPage.dart';
import '../../constant/appRoute.dart';
import '../../controller/internetconnect.dart';
import '../../controller/user_data.dart';
import '../../common/commonfunction.dart';
import '../../constant/colors.dart';
import '../../constant/serverUrl.dart';
import '../createCustomer/createCustomer_screen.dart';
import '../signup/widgetsOfSignUp/textfieldPass_widget.dart';
import 'WidgetsOfSignIn/subTitle_widget.dart';

class SignInScreen extends StatefulWidget {
  static const routename = AppRoute.signinRoute;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passworldcontroller = TextEditingController();
  bool secure = true;
  bool hasInterNetConnection = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConnectionUtilProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    //   showCustomToast(context, "welcome again", AppColor.white);

    return Scaffold(
      backgroundColor: AppColor.mainAppColor,
      body: ListView(
        children: [
          SizedBox(
            height: 200,
          ),
          Form(
            key: _formKey,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: AppDecor.tableDecoration,
                child: Column(
                  children: [
                    //     TitleOfPage("Login now"),
                    SizedBox(
                      height: 40,
                    ),
                    TextField_Widget("Email", _emailcontroller, (value) {
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                        return AppStrings.emailFormatField ;
                      }
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldEmpty;
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    TextFieldPass_Widget(
                        AppStrings.passworld,
                        _passworldcontroller,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldEmpty;
                          }
                          if (value.length < 6) {
                            return AppStrings.passworldValidation;
                          }
                          return null;
                        },
                        secure,
                        () {
                          setState(() {
                            secure = !secure;
                          });
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    StreamBuilder(
                        stream: CommonFunction.isConnectedToInternet.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> isConnectedStream) {
                          bool isConnected = isConnectedStream.hasData
                              ? isConnectedStream.data!
                              : false;
                          debugPrint(
                              CommonFunction.hasInterNetConnection.toString());
                          return CommonFunction.hasInterNetConnection
                              ? Button_widget("SIGN IN", () {
                                  if (_formKey.currentState!.validate()) {
                                    postLogindata();
                                  }
                                })
                              : Container();
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    SubTitle_Widget(AppStrings.haveAccount,AppStrings.singUP , () {
                      navigateTo(context, SignUpScreen());
                    })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  postLogindata() async {
    final body = {
      'odoo_token': "100",
      'user_email': _emailcontroller.text,
      "user_password": _passworldcontroller.text
    };
    var response = await http.post(
        Uri.parse(
          '${Urls.serverURL}/api/v1/login',
        ),
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(body));
    Map jsonBody = jsonDecode(response.body);
    print(jsonBody);

    if (jsonBody['result']['message'] == "User doesn't exist") {
      snackBar(jsonBody['result']['message'], context, AppColor.mainAppColor);
    } else {
      showCustomToast(context, "login successfully", AppColor.white);
      Map userDataa = jsonBody["result"]['result'];
      // context.read<UserData>().userData = userDataa;
      //       context.read<UserData>().setUserDataFunc(userDataa);

      navigateWithoutBack(context, GetCustomerScreen());
    }

    print("${response.isRedirect}");
    return response;
  }
}
