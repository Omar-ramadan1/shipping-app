

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../plugins/Dependentplugins.dart';
import '../../createCustomer/createCustomer_screen.dart';


class FloatingActionButtonCustomer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          navigateTo(context, CreateCustomerScreen());
        },
        tooltip: 'AddProduct',
        child: const Icon(
          Icons.add,
        ),
      );
  }
}