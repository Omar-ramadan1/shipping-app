import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/controller/orders_data.dart';
import 'package:shopapp/constant/colors.dart';
import 'package:shopapp/plugins/Dependentplugins.dart';
import 'package:shopapp/views/signin/signin_screen.dart';
import '../../constant/appRoute.dart';
import '../../controller/Customer_data.dart';
import '../../controller/Product_data.dart';
import '../../controller/internetconnect.dart';
import '../../constant/serverUrl.dart';
import 'WidgetsOfSplash.dart/bodyOfSplash.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashScreen extends StatefulWidget {
  static const routename =AppRoute.splashscreenRoute;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  bool loading = true;
  @override
  void initState() {

    super.initState();
    _navigatetohome();
    checkForLogin("TEST", "admin", "Admin@123");

    context.read<ProductsProvider>().fetchProducts(context);
    context.read<CustomersProvider>().fetchContact(context);
    context.read<SalesProvider>().fetchSales(context);
    context.read<ProductsProvider>().ProductLstOfDeviceDataGet();
    context.read<CustomersProvider>().CustomerLstOfDeviceDataGet();
    context.read<SalesProvider>().salesDataGet();
    context.read<SalesProvider>().SaleLstOfDeviceDataGet();



  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 4000), () {
      navigateWithoutBack(context, SignInScreen());
    });
  }

  final orpc = OdooClient(Urls.serverURL);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.mainAppColor,
      body: Body_Widget());
  }

  Future<dynamic> checkForLogin(
      String db, String username, String passworld) async {
    try {
      // try the input data

      await orpc.authenticate(db == null ? "" : db,
          username == null ? "" : username, passworld == null ? "" : passworld);
      print(orpc.sessionId);
      print(orpc.sessionStream);

      //in case of sining in successfully
    } on OdooException catch (e) {
      //print the error
      print("error ya omar iss ${e}");
      print("error ya omar is ${e.message}");

      // in case of exception show snackbar
      snackBar("check your internt", context, Colors.red);
    } finally {
      print("lol");
    }
  }
}
