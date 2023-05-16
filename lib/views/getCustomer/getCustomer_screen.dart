import 'dart:convert';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../constant/appRoute.dart';
import '../../controller/Customer_data.dart';
import '../../controller/internetconnect.dart';
import '../../controller/orders_data.dart';
import '../../common/common_widget.dart/appbar_widget.dart';
import '../../common/common_widget.dart/card_widget.dart';
import '../../common/commonfunction.dart';
import '../../constant/colors.dart';
import '../../models/customer_model.dart';
import '../../plugins/Dependentplugins.dart';
import '../drawer/drawer.dart';
import '../signup/widgetsOfSignUp/textfield_widget.dart';
import 'getCustomer_Widgets/floatActionButton.dart';

class GetCustomerScreen extends StatefulWidget {
  static const routename = AppRoute.getCustomerRoute;

  @override
  State<GetCustomerScreen> createState() => _GetCustomerScreenState();
}

class _GetCustomerScreenState extends State<GetCustomerScreen> {
  bool internet = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  final TextEditingController _passworldcontroller = TextEditingController();
  final TextEditingController _passworldnewcontroller = TextEditingController();
  List<Customer> customer =
      Customer.fromJsonStringListToCustomerList(jsonEncode(Customers));

  // connectionChangedd(dynamic hasConnection) {
  //   setState(() {
  //     hasInterNetConnection = hasConnection;
  //     hasInterNetConnection
  //         ? snackBar("text", context, AppColor.mainAppColor)
  //         : snackBar("no", context, AppColor.mainAppColor);
  //     // snackBar("text", context, AppColor.blue);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    context.read<CustomersProvider>().fetchContact(context);
    print("cust is  $Customers");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar_widget(
            "Customer",
            StreamBuilder(
                stream: CommonFunction.isConnectedToInternet.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<bool> isConnectedStream) {
                  bool isConnected = isConnectedStream.hasData
                      ? isConnectedStream.data!
                      : false;
                  debugPrint(CommonFunction.hasInterNetConnection.toString());
                  return CommonFunction.hasInterNetConnection
                      ? CustomersLstOfDevice.length > 0
                          ? IconButton(
                              onPressed: () async {
                                AppBarFunction();
                              },
                              icon: badges.Badge(
                                  badgeContent: Text(
                                      '${CustomersLstOfDevice.length.toString()}'),
                                  child: Icon(Icons.sync)))
                          : Container()
                      : Container();
                }
                )
                ),
        drawer: Drawer_Widget(),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: customer.length,
                  itemBuilder: (BuildContext context, int i) {
                    print("cust is  $Customers");
                    return Card_widget(
                      customer[i].name.toString(),
                      customer[i].email.toString(),
                      () {},
                      internet,
                      costOfProduct: "",
                    );
                  }),
              for (int i = 0; i < CustomersLstOfDevice.length; i++)
                Card_widget(
                    CustomersLstOfDevice[i]['name'],
                    CustomersLstOfDevice[i]['email'].toString(),
                    () {},
                    internet)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButtonCustomer());
  }

  Future<void> _refresh() async {
    context.read<CustomersProvider>().fetchContact(context);
    setState(() {});
  }

  AppBarFunction() {
    for (int i = 0; i < CustomersLstOfDevice.length; i++) {
      context.read<CustomersProvider>().createCustomer(
            context,
            CustomersLstOfDevice[i]['name'],
            CustomersLstOfDevice[i]['phone'],
            CustomersLstOfDevice[i]['city'],
            CustomersLstOfDevice[i]['contact_address'],
            //CustomersLstOfDevice[0]['image_1920'],
          );
    }
    print(CustomersLstOfDevice);
    CustomersLstOfDevice = [];
    context
        .read<CustomersProvider>()
        .CustomerLstOfDeviceDataSet(CustomersLstOfDevice);

    //   }
    setState(() {});

    print("CustomersLstOfDevice is ${CustomersLstOfDevice}");
  }
}
