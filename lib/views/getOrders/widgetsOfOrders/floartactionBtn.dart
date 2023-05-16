import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/views/createOrder/CreateOrder_screen.dart';

import '../../../plugins/Dependentplugins.dart';
import '../../createCustomer/createCustomer_screen.dart';

class FloatingActionButtonOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () {
        navigateTo(context, CreateOrderScreen());
      },
      tooltip: 'AddProduct',
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
