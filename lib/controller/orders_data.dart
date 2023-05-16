import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/colors.dart';
import '../constant/serverUrl.dart';
import '../models/order_model.dart';
import '../plugins/Dependentplugins.dart';

List Sales = [];
List SalestOfDevice = [];

class SalesProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final orpc = OdooClient(Urls.serverURL);
// login to database for actions

  // login to database for actions
  Future<dynamic> check(BuildContext context) async {
    try {
      // await orpc.authenticate("Omar", "ali", "123456");
      await orpc.authenticate("TEST",  "admin" ,
          "Admin@123");
      print("orpc.sessionId  is ${orpc.sessionId!}");
      print("orpc.baseURL is ${orpc.baseURL}");
      print("orpc.httpClient is ${orpc.httpClient}");
    } on OdooException catch (e) {
      print("error ya omar iss ${e}");
      
    } finally {
      print("lol");
    }
  }

  // get sales from serve
  Future<dynamic> fetchSales(BuildContext context) async {
    await check(context);

    Sales = await orpc.callKw({
      'model': 'sale.order',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [
          'id',
          'name',
         // 'tax_totals_json',
          'amount_total',
          'partner_id',
          'order_line'
        ],
        'limit': 50,
      }
    });

List<Sale> saleList =
        Sale.fromJsonStringListToCustomerList(jsonEncode(Sales));
        debugPrint(Sale.fromCustomerListtoPrintableString(saleList) , wrapWidth: 200);
    salessDataSet(Sales);
    print("sales20 is ${Sales}");
    return Sales;
  }


  CraeteSale(BuildContext context, int partner_id, String partner_name,
      List lines) async {
    final body = {
      "odoo_token": "100",
      "partner_id": partner_id,
      "partner_name": partner_name,
      "lines": lines
    };
    var response = await http.post(
        Uri.parse(
          '${Urls.serverURL}/api/v1/create_order',
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: json.encode(body));
    if (response.statusCode == 200) {
      print("tmam");
    } else {
      snackBar(response.statusCode.toString(), context, AppColor.blue);
    }

    return response;
  }

//get sharedpreferences data of sales that came from server
  void salesDataGet() async {
    final SharedPreferences prefs = await _prefs;
    try {
      Sales = jsonDecode(prefs.getString("salesData") == null
          ? "null"
          : prefs.getString("salesData")!);
    } on Error catch (e) {
      print(e);
      print(e);
    } finally {
      print("lol");
    }
    print("final token data is ${Sales}");
    notifyListeners();
  }

  // set sharedpreferences data of contacts that came from server
  void salessDataSet(List salesData) async {
    Sales = salesData;
    print("tokendata from fun is $salesData");
    final SharedPreferences prefs = await _prefs;
    prefs.setString("salesData", jsonEncode(salesData));
    //  print(userData);
    notifyListeners();
  }

//get sharedpreferences data of contact that store local on device
  void SaleLstOfDeviceDataGet() async {
    final SharedPreferences prefs = await _prefs;
    //   prefs.clear();
    try {
      SalestOfDevice = jsonDecode(prefs.getString("SalestOfDeviceData") == null
          ? "null"
          : prefs.getString("SalestOfDeviceData")!);
    } on Error catch (e) {
      print(e);
      print("a7a");
    } finally {
      print("a7a 2");
    }
    print("final token data is ${SalestOfDevice}");
    notifyListeners();
  }

  // set sharedpreferences data of products that store local on the device
  void SaleLstOfDeviceDataSet(List SaleLstOfDeviceParameter) async {
    SalestOfDevice = SaleLstOfDeviceParameter;
    print("tokendata from fun is $SaleLstOfDeviceParameter");
    final SharedPreferences prefs = await _prefs;
    prefs.setString("SalestOfDeviceData", jsonEncode(SaleLstOfDeviceParameter));
    //  print(userData);
    notifyListeners();
  }

  void fetchProducts(BuildContext context) {}
}
