import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shopapp/common/appDecor.dart';
import 'package:shopapp/constant/appRoute.dart';
import 'package:shopapp/constant/strings.dart';
import 'package:shopapp/views/signin/signin_screen.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/button_widget.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/showmodel_widget.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/textfieldPass_widget.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/textfield_widget.dart';
import 'package:shopapp/views/signup/widgetsOfSignUp/titleOfPage.dart';
import 'package:http/http.dart' as http;
import '../../constant/colors.dart';
import '../../constant/serverUrl.dart';
import '../../plugins/Dependentplugins.dart';
import '../signin/WidgetsOfSignIn/subTitle_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const routename =AppRoute.signupRoute;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  final TextEditingController _passworldcontroller = TextEditingController();
  final TextEditingController _passworldnewcontroller = TextEditingController();
  bool secure = true;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainAppColor,
      body: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          Form(
            key: _formKey,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: AppDecor.tableDecoration,
                child: Column(
                  children: [
                    TitleOfPage("Create an account"),
                    SizedBox(
                      height: 40,
                    ),
                    TextField_Widget(AppStrings.name, _namecontroller, (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldEmpty;
                      }
                      if (value.length < 3) {
                        return AppStrings.nameValidationfield;
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    TextField_Widget(AppStrings.email, _emailcontroller, (value) {
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                        return AppStrings.emailFormatField;
                      }
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldEmpty;
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    TextField_Widget(AppStrings.phone, _phonecontroller, (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldEmpty;
                      }
                      String patttern = r'^01[0125][0-9]{8,9}$';
                      RegExp regExp = new RegExp(patttern);
                      if (!regExp.hasMatch(value)) {
                        return "please enter the phone in egypt format";
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    TextFieldPass_Widget(
                        "Passworld",
                        _passworldcontroller,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldEmpty;
                          }
                          if (value.length < 6) {
                            return 'passworld must be at least 6 numbers';
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
                    TextFieldPass_Widget(
                        "Confirm Passworld",
                        _passworldnewcontroller,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldEmpty;
                          }
                          if (value.length < 6) {
                            return AppStrings.passworldValidation;
                          }
                          if (value != _passworldcontroller.text) {
                            return AppStrings.passworldDontMatch;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = !_isChecked;
                              });
                            }),
                        InkWell(
                            onTap: () {
                              Funcations().showmode(context);
                            },
                            child: Text("terms and conditions"))
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Button_widget(AppStrings.singUP, () {
                      if (_formKey.currentState!.validate()) {
                        if (_isChecked == true) {
                          postSignUpdata();
                        } else {
                          snackBar(AppStrings.checkTermsAndConditions, context,
                              AppColor.mainAppColor);
                        }
                      }
                    }),
                    SubTitle_Widget(AppStrings.haveAnAccount,AppStrings.singIn, () {
                      navigateTo(context, SignInScreen());
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

  postSignUpdata() async {
    final body = {
      'odoo_token': "100",
      "user_name": _namecontroller.text,
      'user_email': _emailcontroller.text,
      "user_password": _passworldcontroller.text,
      "user_phone": _phonecontroller.text
    };
    var response = await http.post(
        Uri.parse(
          '${Urls.serverURL}/api/v1/sign_up',
        ),
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(body));
    Map jsonBody = jsonDecode(response.body);
    print(jsonBody);

    if (jsonBody['result']['message'] == "user exist already") {
      snackBar(jsonBody['result']['message'], context, AppColor.mainAppColor);
    } else {
      navigateWithoutBack(context, SignInScreen());
      showCustomToast(
          context,
          "congratulation you have made your account successfully",
          AppColor.white);
    }

    print("${response.isRedirect}");
    return response;
  }
}
