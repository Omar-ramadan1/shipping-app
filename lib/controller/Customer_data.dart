import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/serverUrl.dart';
import '../models/customer_model.dart';


List Customers = [];

List CustomersLstOfDevice = [];

class CustomersProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final orpc = OdooClient(Urls.serverURL);

  // login to database for actions
  Future<dynamic> check(BuildContext context,) async {
    try {
      // await orpc.authenticate("Omar", "ali", "123456");
      await orpc.authenticate("TEST",  "admin" ,
          "Admin@123");
      print("orpc.sessionId  is ${orpc.sessionId!}");
      print("orpc.baseURL is ${orpc.baseURL}");
      print("orpc.httpClient is ${orpc.httpClient}");
    } on OdooException catch (e) {
      print("error ya omar iss ${e}");
      print("error ya omar is ${e.message}");
    } finally {
      print("lol");
    }
  }

  Future<dynamic> createCustomer(BuildContext context, String nameOfProberty,
      String phone, String city, String address) async {
    await check(context,);

    int Prod = await orpc.callKw({
      'model': 'res.partner',
      'method': 'create',
      'args': [
        {
          'name': nameOfProberty,
          'phone': phone,
          'city': city,
          "contact_address":address
          // 'image_1920': image
        }
      ],
      'kwargs': {}
    });
    // print(Products);
    notifyListeners();
    print("Prod  ${Prod}");
    return Prod;
  }

// get contacts from serve
  Future<dynamic> fetchContact(BuildContext context) async {
    //await context.read<CheckLoginProvider>().check(context, db, name, pass);
    await check(context);

    Customers = await orpc.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [
          'id',
          'name',
          'email',
          '__last_update',
          'image_1920',
          'customer_rank',
          'mobile',
          'phone',
          'website'
        ],
        'limit': 80,
      }
    });
    List<Customer> customerList =
        Customer.fromJsonStringListToCustomerList(jsonEncode(Customers));
    contactssDataSet(Customers);
  //  debugPrint(Customer.fromCustomerListtoPrintableString(customerList) , wrapWidth: 200);
    return Customers;
  }

  void contactsDataGet() async {
    final SharedPreferences prefs = await _prefs;
    //   prefs.clear();

    Customers = jsonDecode(prefs.getString("customersData") == null
        ? "null"
        : prefs.getString("customersData")!);
    print("final token data is ${Customers}");
    notifyListeners();
  }

  // set sharedpreferences data of contacts that came from server
  void contactssDataSet(List customersData) async {
    Customers = customersData;
  //  print("tokendata from fun is $customersData");
    final SharedPreferences prefs = await _prefs;
    prefs.setString("customersData", jsonEncode(customersData));
    //  print(userData);
    notifyListeners();
  }

  //get sharedpreferences data of contact that store local on device
  void CustomerLstOfDeviceDataGet() async {
    final SharedPreferences prefs = await _prefs;
    try {
      CustomersLstOfDevice = jsonDecode(
          prefs.getString("CustomersLstOfDeviceData") == null
              ? "null"
              : prefs.getString("CustomersLstOfDeviceData")!);
    } on Error catch (e) {
      print(e);
    } finally {
      print("a7a");
    }
    print("final token data is ${CustomersLstOfDevice}");
    notifyListeners();
  }

  // set sharedpreferences data of contacts that store local on the device
  void CustomerLstOfDeviceDataSet(List CustomersLstOfDeviceParameter) async {
    CustomersLstOfDevice = CustomersLstOfDeviceParameter;
   // print("tokendata from fun is $CustomersLstOfDeviceParameter");
    final SharedPreferences prefs = await _prefs;
    prefs.setString(
        "CustomersLstOfDeviceData", jsonEncode(CustomersLstOfDeviceParameter));
    //  print(userData);
    notifyListeners();
  }
}
