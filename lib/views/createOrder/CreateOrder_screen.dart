import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:provider/provider.dart';
import 'package:shopapp/views/getOrders/getOrder_screen.dart';

import '../../constant/appRoute.dart';
import '../../controller/Customer_data.dart';
import '../../controller/Product_data.dart';
import '../../controller/orders_data.dart';
import '../../common/appDecor.dart';
import '../../constant/colors.dart';
import '../../plugins/Dependentplugins.dart';
import 'WidgetOfCreateOrder/CardOfCreate.dart';

class CreateOrderScreen extends StatefulWidget {
  static const routename = AppRoute.createorderRoute;

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  List<String> CustomerList = ["TEST", "Omar"];
  List<String> CustomersIdList = [];
  List<String> CustomersNameList = [];
  int? id;

  List Create_Order = [];

  Map probertyOfOrder = {
    "id": "",
  };

  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    getCustomers();
  }

  String? value;
  getCustomers() {
    Customers.forEach((element) {
      CustomersIdList.add(element['id'].toString());
      CustomersNameList.add(element['name']);

      // print("id is $CustomersIdList");
      // print("name is $CustomersNameList");
    });
    //     context.read<DataCenterOfProject>().fetchSales(context);
  }

  TextEditingController _quantitycontroller = TextEditingController();

  getCustomerId(String value) {
    for (int i = 0; i < CustomersIdList.length; i++) {
      if (value == CustomersNameList[i]) {
        setState(() {
          id = int.parse(CustomersIdList[i]);
          print("choosenIdis $id");
        });
      }
    }

    //     context.read<DataCenterOfProject>().fetchSales(context);
  }

  bool internet = false;
  String? valuee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New"),
          actions: [
            IconButton(
                onPressed: () {
                  _AddSale();
                },
                icon: Icon(Icons.save))
          ],
          backgroundColor: AppColor.mainAppColor,
        ),
        body: ListView(
          children: [
            _SelectCustomer(),
            Padding(
              padding:
                  const EdgeInsets.only(right: 8, left: 8, top: 40, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                            child: ListView(
                                                shrinkWrap: true,
                                                children: <Widget>[
                                              for (int i = 0;
                                                  i < Products.length;
                                                  i++)
                                                CardOfCreate_widget(
                                                  Products[i]['name'],
                                                  "500",
                                                  () {
                                                    Create_Order.add({
                                                      "product_id": Products[i]
                                                          ['id'],
                                                      "product_name":
                                                          Products[i]['name'],
                                                      "price_unit": Products[i]
                                                          ['standard_price'],
                                                      "qty": 1
                                                    });
                                                    Navigator.pop(context);
                                                    print(
                                                        "Create_Order is $Create_Order");
                                                    setState(() {});
                                                  },
                                                  internet,
                                                  costOfProduct:
                                                      "${Products[i]['standard_price'].toString()}\$",
                                                ),
                                            ]))
                                      ]),
                                ),
                              );
                            });
                      },
                      child: Text(
                        "Add order_line",
                        style: TextStyle(fontSize: 17, color: AppColor.red),
                      )),
                  Icon(Icons.camera_alt)
                ],
              ),
            ),
            for (int i = 0; i < Create_Order.length; i++)
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      child: ListView(
                                          //  shrinkWrap: true,
                                          children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(Create_Order[i]
                                                ['product_name']),
                                            // Icon(Icons.save)
                                            IconButton(
                                                onPressed: () {
                                                  Create_Order[i]['qty'] =
                                                      int.parse(valuee!);
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.save))
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            //   controller: _quantitycontroller,
                                            onChanged: (value) {
                                              setState(() {
                                                this.valuee = value;
                                                print(valuee);
                                              });
                                            },

                                            decoration: InputDecoration(
                                                //label:,

                                                labelText: "Quantity",
                                                contentPadding:
                                                    EdgeInsets.only(top: 10),
                                                //   hintText: "Quantity",
                                                hintStyle: TextStyle(
                                                  color: AppColor.grey,
                                                ),
                                                alignLabelWithHint: false,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        BorderSide.none),
                                                filled: true,
                                                fillColor: Color(0xFFDBDBDB),
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          bottom: 15,
                                                          top: 15),
                                                  child: Icon(Icons.numbers),
                                                )),
                                          ),
                                        )
                                      ]))
                                ]),
                          ),
                        );
                      });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              Create_Order[i]['product_name'],
                              style: TextStyle(
                                  color: AppColor.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("UNIT PRICE"),
                            Text("${Create_Order[i]['price_unit'].toString()}"),
                            Text("TAXES"),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 33, bottom: 11),
                              child: Text("QUANTITY",
                                  style: TextStyle(fontSize: 14)),
                            ),
                            Text("${Create_Order[i]['qty']}"),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 33, bottom: 11),
                              child: Text("DISCOUNT",
                                  style: TextStyle(fontSize: 14)),
                            ),
                            Text("00.00"),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 33, bottom: 11),
                              child: Text(
                                "SUB TOTAL",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                                "${Create_Order[i]['qty'] * Create_Order[i]['price_unit']}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ));
  }

  Widget _SelectCustomer() {
    return Card(
      child: Container(
          // padding: EdgeInsets.only(left: 6, right: 6),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 10,
          child: Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                //  icon: Icon(Icons.abc_sharp),
                hint: Center(
                  child: const Text(
                    "PLEASE SELECT CUSTOMER",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                iconSize: 0,
                value: value,
                style: TextStyle(color: AppColor.grey),
                //   isExpanded: true,
                items: CustomersNameList.map(AppDecor().buildmenuItem).toList(),
                onChanged: (value) {
                  setState(() {
                    this.value = value!;
                    print(value);
                    getCustomerId(value);
                  });
                },
              ),
            ),
          )),
    );
  }

  _AddSale() {
    // context
    //     .read<SalesProvider>()
    //     .CraeteSale(context, id!, "Omar", Create_Order);
    print(value);
    print(Create_Order.length);
    if (value == null || Create_Order.length == 0) {
      snackBar("please enter the data", context, AppColor.blue);
    } else {
      SalestOfDevice.add({
        "odoo_token": "100",
        "partner_id": id!,
        "partner_name": "orderCreated",
        "lines": Create_Order
      });
      context.read<SalesProvider>().SaleLstOfDeviceDataSet(SalestOfDevice);

      navigateWithoutBack(context, GetOrderScreen());
    }
  }
}
