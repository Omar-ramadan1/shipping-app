import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/controller/user_data.dart';
import 'package:shopapp/views/createCustomer/createCustomer_screen.dart';
import 'package:shopapp/views/createOrder/CreateOrder_screen.dart';
import 'package:shopapp/views/getCustomer/getCustomer_screen.dart';
import 'package:shopapp/views/getOrders/getOrder_screen.dart';
import 'package:shopapp/views/resetPassworld/resetPassworld_screen.dart';
import 'package:shopapp/views/signin/signin_screen.dart';
import 'package:shopapp/views/signup/signup_screen.dart';
import 'package:shopapp/views/splash/splash_screen.dart';
import 'package:shopapp/views/termsAndConditions/termsAndConditions_screen.dart';

import 'controller/Customer_data.dart';
import 'controller/Product_data.dart';
import 'controller/internetconnect.dart';
import 'controller/orders_data.dart';
import 'common/commonfunction.dart';

void main() {
//   ConnectionUtilProvider connectionStatus = ConnectionUtilProvider.getInstance();
//     connectionStatus.initialize();
//     connectionStatus.connectionChange.listen(
// CommonFunction().connectionChanged
//           );

  runApp(MultiProvider(
    providers:[
      // ChangeNotifierProvider(create: (_) => CommonFunction()),
       ChangeNotifierProvider(create: (_) => UserData()),

        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CustomersProvider()),
        ChangeNotifierProvider(create: (_) => SalesProvider()),

    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipping',
      theme: ThemeData(
                primarySwatch: Colors.blue,
      ),
      home:  SplashScreen(),
      routes: {
        SignInScreen.routename:(ctx) => SignInScreen(),
        SignUpScreen.routename:(ctx) => SignUpScreen(),
        SplashScreen.routename:(ctx) => SplashScreen(),
        CreateOrderScreen.routename:(ctx) =>CreateOrderScreen(),
        CreateCustomerScreen.routename:(ctx) =>CreateCustomerScreen(),
        GetCustomerScreen.routename:(ctx)=> GetCustomerScreen(),
        GetOrderScreen.routename:(ctx) =>GetOrderScreen(),
        ResetPassworldScreen.routename:(ctx) => ResetPassworldScreen(),
        TermsAndCondition.routename:(ctx)=> TermsAndCondition()
      },
    );
  }
}
