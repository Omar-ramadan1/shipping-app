import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopapp/views/getOrders/widgetsOfOrders/floartactionBtn.dart';

import '../../constant/appRoute.dart';
import '../../controller/orders_data.dart';
import '../../common/common_widget.dart/appbar_widget.dart';
import '../../common/common_widget.dart/card_widget.dart';
import '../../common/commonfunction.dart';
import '../../models/order_model.dart';
import '../drawer/drawer.dart';


class GetOrderScreen extends StatefulWidget {
  static const routename = AppRoute.getorderRoute;

  @override
  State<GetOrderScreen> createState() => _GetOrderScreenState();
}

class _GetOrderScreenState extends State<GetOrderScreen> {
  bool internet = false;


  List<Sale> sale = Sale.fromJsonStringListToCustomerList(jsonEncode(Sales));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SalesProvider>().fetchSales(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_widget(
          "POS Orders",
           StreamBuilder(
                stream: CommonFunction.isConnectedToInternet.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<bool> isConnectedStream) {
                  bool isConnected = isConnectedStream.hasData
                      ? isConnectedStream.data!
                      : false;
                  debugPrint(CommonFunction.hasInterNetConnection.toString());
                  return CommonFunction.hasInterNetConnection
              ? SalestOfDevice.length > 0
                  ? IconButton(
                      onPressed: () {
                        print(SalestOfDevice);
                        // 4
                        for (int i = 0; i < SalestOfDevice.length; i++) {
                          context.read<SalesProvider>().CraeteSale(
                              context,
                              SalestOfDevice[i]['partner_id']!,
                              SalestOfDevice[i]['partner_name'],
                              SalestOfDevice[i]['lines']);
                        }
                        SalestOfDevice = [];
                        context
                            .read<SalesProvider>()
                            .SaleLstOfDeviceDataSet(SalestOfDevice);
                        setState(() {});

                        // for (var salestOfDevice in SalestOfDevice) {

                        //   //   }
                        // }
                      },
                      icon: badges.Badge(
                          badgeContent:
                              Text('${SalestOfDevice.length.toString()}'),
                          child: Icon(Icons.sync)))
                  : Container()
              : Container();
               }
                )),
      drawer: Drawer_Widget(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            //for show data that comes from server
            _ShowItemBuilder(),

            //for show local data 
            for (int i = 0; i < SalestOfDevice.length; i++)
              Card_widget(
                SalestOfDevice[i]['partner_name'],
                "",
                () {},
                true,
                costOfProduct: "",
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonOrders()
    );
  }

  Widget _ShowItemBuilder() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sale.length,
        itemBuilder: (BuildContext context, int i) {
          print("sale.l is ${sale.length} ${sale}");
          return Card_widget(
            sale[i].name.toString(),
            "500",
            () {
              // navigateWithArgument(
              //     context, CharacterDetailsScreen.routename, sale[i]);
            },
            internet,
            costOfProduct: "",
          );
        });
  }

  Future<void> _refresh() async {
        context.read<SalesProvider>().fetchSales(context);
        setState(() {
          
        });

   
  }
}
