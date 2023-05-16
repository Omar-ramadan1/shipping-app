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


List Products = [];
List ProductLstOfDevice = [];

class ProductsProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final orpc = OdooClient(Urls.serverURL);

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
      print("orpc.sessionId  is ${orpc.sessionId}");
      print("orpc.baseURL is ${orpc.baseURL}");
      print("orpc.httpClient is ${orpc.httpClient}");
      print("error ya omar is ${e.message}");
    } finally {
      print("lol");
    }
  }

  // get products

  Future<dynamic> fetchProducts(BuildContext context) async {
    await check(context);

    Products = await orpc.callKw({
      'model': 'product.template',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [
          'id',
          'standard_price',
          'image_1920',
          'name',
          'barcode',
          'default_code',
          'detailed_type',
        ],
        'limit': 80,
      }
    });
    // print(Products);
    notifyListeners();

    productsDataSet(Products);

    print("product is $Products");

    return Products;
  }

// create products
  Future<dynamic> createProducts(BuildContext context, String nameOfProberty,
      double standard_price, String default_code, String image) async {
    await check(context);
    print("mmmmmmmmmmmmmmmmm");
    int Prod = await orpc.callKw({
      'model': 'product.template',
      'method': 'create',
      'args': [
        {
          'name': nameOfProberty,
          'list_price': standard_price,
          'default_code': default_code,
          'image_1920': image
        }
      ],
      'kwargs': {}
    });
    print("mmmmmmmmmmmmmmmmmk");

    // print(Products);
    notifyListeners();
    print("Prod  ${Prod}");
    return Prod;
  }

  // get sharedpreferences data of products that came from server

  void productsDataGet() async {
    final SharedPreferences prefs = await _prefs;
    //   prefs.clear();

    Products = jsonDecode(prefs.getString("ProductsData") == null
        ? "null"
        : prefs.getString("ProductsData")!);
    print("final token data is ${Products}");
    notifyListeners();
  }

  // set sharedpreferences data of products that came from server

  void productsDataSet(List ProductsData) async {
    Products = ProductsData;
    print("tokendata from fun is $ProductsData");
    final SharedPreferences prefs = await _prefs;
    prefs.setString("ProductsData", jsonEncode(ProductsData));
    //  print(userData);
    notifyListeners();
  }

//get sharedpreferences data of contact that store local on device

  void ProductLstOfDeviceDataGet() async {
    final SharedPreferences prefs = await _prefs;
    //   prefs.clear();
    try {
      ProductLstOfDevice = jsonDecode(
          prefs.getString("ProductLstOfDeviceData") == null
              ? "null"
              : prefs.getString("ProductLstOfDeviceData")!);
    } on Error catch (e) {
      print(e);
      print("a7a");
    } finally {
      print("a7a 2");
    }
    print("final token data is ${ProductLstOfDevice}");
    notifyListeners();
  }

  // set sharedpreferences data of products that store local on the device

  void ProductLstOfDeviceDataSet(List ProductLstOfDeviceParameter) async {
    ProductLstOfDevice = ProductLstOfDeviceParameter;
    print("tokendata from fun is $ProductLstOfDeviceParameter");
    final SharedPreferences prefs = await _prefs;
    prefs.setString(
        "ProductLstOfDeviceData", jsonEncode(ProductLstOfDeviceParameter));
    //  print(userData);
    notifyListeners();
  }
}
