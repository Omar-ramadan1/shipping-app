import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../controller/internetconnect.dart';
import '../constant/colors.dart';
import '../plugins/Dependentplugins.dart';

class CommonFunction {
  static bool hasInterNetConnection = false;

  static StreamController<bool> isConnectedToInternet =
      StreamController<bool>.broadcast();

  static connectionChanged(bool hasConnection) {
    hasInterNetConnection = hasConnection;
    isConnectedToInternet.sink.add(hasConnection);
    // snackBar("text", context, AppColor.blue);
  }
}
