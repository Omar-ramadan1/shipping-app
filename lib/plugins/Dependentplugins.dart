import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

navigateTo(BuildContext context, destintaion) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => destintaion),
  );
}

navigateWithArgument(BuildContext context, String routeName, Object argument) {
  Navigator.pushNamed(
    context,
    routeName,
    arguments: argument,
  );
}

navigateWithoutBack(BuildContext context, destintaion) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => destintaion),
    (Route<dynamic> route) => false,
  );
}

alertDialog(
    BuildContext context, String content, Widget widget, Widget widget2) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      content,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ],
            ),
          ),
          actions: [widget, widget2],
        );
      });
}

snackBar(text, context, Color color) {
  SnackBar snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showCustomToast(BuildContext context, String msg, Color color) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    child: Text(
      msg,
      style: TextStyle(fontSize: 16),
    ),
  );

  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM);
}

// Future<void> launchInBrowser(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.externalNonBrowserApplication,
//   )) {
//     throw 'Could not launch $url';
//   }
// }

