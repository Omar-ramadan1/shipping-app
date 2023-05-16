import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/constant/colors.dart';
import '../constant/serverurl.dart';
import '../models/userdata_moder.dart';
import '../plugins/Dependentplugins.dart';


class UserData with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Map? _userData;

  Map? get userData => _userData;

  getprofile(BuildContext context) async {
    var url = Uri.parse('${Urls.serverURL}/api/v1/get_user_info');
    var res = await http.get(
      url,
      headers: <String, String>{"Content-Type": "application/json"},

    );
     final bodyy = {
      'odoo_token': "100",
      "user_id": "10"

    };

    Map jsonBody = jsonDecode(res.body);
    Map result = jsonBody['result']['result'];
    if (res.statusCode == 200) {
       return Userdata.fromJson(jsonBody['result']['result']);
    } else {
      snackBar(res.statusCode.toString(), context,AppColor.mainAppColor);
    }
  }

// to assign userdata to get just userId
  set userData(Map? UserDataParameter) {
    _userData = UserDataParameter;
    notifyListeners();
  }

  //
  void getUserData() async {
    final SharedPreferences prefs = await _prefs;
    // prefs.clear();
    print("final user data is $_userData");

    _userData = jsonDecode(prefs.getString("userDataaaa") == null
        ? "null"
        : prefs.getString("userDataaaa")!);

    print("final user data is $_userData");
    notifyListeners();
  }

  void setUserDataFunc(Map UserDataParameter) async {
    userData = UserDataParameter;
    final SharedPreferences prefs = await _prefs;
    prefs.setString("userDataaaa", jsonEncode(UserDataParameter));
    notifyListeners();
  }

  void clearallsharedpreference() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('userDataaaa');

    await prefs.clear();
    print("clear user data is $_userData");
    notifyListeners();
  }
}
