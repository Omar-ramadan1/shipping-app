import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/plugins/Dependentplugins.dart';

import '../../constant/appRoute.dart';
import '../../constant/strings.dart';
import '../../controller/Customer_data.dart';
import '../../controller/internetconnect.dart';
import '../../common/common_widget.dart/appbar_widget.dart';
import '../getCustomer/getCustomer_screen.dart';
import '../signup/widgetsOfSignUp/button_widget.dart';
import '../signup/widgetsOfSignUp/textfield_widget.dart';

class CreateCustomerScreen extends StatefulWidget {
  static const routename = AppRoute.createCustomerRoute;

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  final TextEditingController _citycontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_widget(AppStrings.createCutomer, Container()),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField_Widget(AppStrings.name, _namecontroller, (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.fieldEmpty ;
              }
              if (value.length < 3) {
                return AppStrings.nameValidationfield ;
              }
              return null;
            }),
            SizedBox(
              height: 25,
            ),
            TextField_Widget(AppStrings.phone, _phonecontroller, (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.fieldEmpty;
              }
              String patttern = r'^01[0125][0-9]{8,9}$';
              RegExp regExp = new RegExp(patttern);
              if (!regExp.hasMatch(value)) {
                return AppStrings.phoneValidationfield;
              }
              return null;
            }),
            SizedBox(
              height: 25,
            ),
            TextField_Widget(AppStrings.city, _citycontroller, (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.fieldEmpty;
              }
              if (value.length < 3) {
                return AppStrings.cityValidationfield;
              }
              return null;
            }),
            SizedBox(
              height: 25,
            ),
            TextField_Widget(AppStrings.street, _addresscontroller, (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.fieldEmpty;
              }
              if (value.length < 3) {
                return AppStrings.streetValidationfield;
              }
              return null;
            }),
            SizedBox(
              height: 35,
            ),
            Column(
              children: [
                Button_widget(AppStrings.saveCustomer, () {
                  _addCustomer();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _addCustomer() {
    if (_formKey.currentState!.validate()) {
      CustomersLstOfDevice.add({
        "name": _namecontroller.text,
        "phone": _phonecontroller.text,
        "city": _citycontroller.text,
        "contact_address": _addresscontroller.text,
      });
              context
            .read<CustomersProvider>()
            .CustomerLstOfDeviceDataSet(CustomersLstOfDevice);
      navigateWithoutBack(context, GetCustomerScreen());
      print(CustomersLstOfDevice);

      //  navigateTo(context, CustomerScreen());
    }
  }
}
