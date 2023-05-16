import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/constant/strings.dart';
import 'package:shopapp/plugins/Dependentplugins.dart';
import 'package:http/http.dart' as http;
import '../../constant/appRoute.dart';
import '../../controller/Customer_data.dart';
import '../../controller/internetconnect.dart';
import '../../controller/user_data.dart';
import '../../common/common_widget.dart/appbar_widget.dart';
import '../../constant/colors.dart';
import '../../constant/serverUrl.dart';
import '../getCustomer/getCustomer_screen.dart';
import '../signup/widgetsOfSignUp/button_widget.dart';
import '../signup/widgetsOfSignUp/textfield_widget.dart';

class ResetPassworldScreen extends StatefulWidget {
  static const routename = AppRoute.resetPassworldScreen;

  @override
  State<ResetPassworldScreen> createState() => _ResetPassworldScreenState();
}

class _ResetPassworldScreenState extends State<ResetPassworldScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passworldcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_widget(AppStrings.resetPassorld, Container()),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField_Widget(AppStrings.newPassworld, _passworldcontroller, (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.fieldEmpty;
              }
              if (value.length < 6) {
                return AppStrings.passworldValidation;
              }
              return null;
            }),
            SizedBox(
              height: 25,
            ),
            Column(
              children: [
                Button_widget(AppStrings.submint, () {
                  _resetPasswordFunction();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _resetPasswordFunction() {
    if (_formKey.currentState!.validate()) {
      resetPassworldApi();
    }
  }

  resetPassworldApi() async {
    //print("${context.read<UserData>().userData!['user_id']}");
    final body = {
      'odoo_token': "100",
      //'user_id': context.read<UserData>().userData!['user_id'],
      "user_password": _passworldcontroller.text
    };
    var response = await http.post(
        Uri.parse(
          '${Urls.serverURL}/api/v1/reset_password',
        ),
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(body));
    Map jsonBody = jsonDecode(response.body);
    print(jsonBody);

    if (jsonBody['result']['result'] == "Update Password") {
      snackBar("passworld changed", context, AppColor.mainAppColor);
      navigateWithoutBack(context, GetCustomerScreen());
    } else {
      snackBar("somethinge go worng", context, AppColor.red);
    }

    print("${response.isRedirect}");
    return response;
  }
}
