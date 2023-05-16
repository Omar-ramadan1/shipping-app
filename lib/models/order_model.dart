import 'dart:convert';

class Sale {
  int? id;
  String? name;
  double? amountTotal;

  Sale({this.id, this.name, this.amountTotal});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amountTotal = json['amount_total'];
  }

 Map toJson() {
    return {
      "id": id,
      "name": name,
      "amountTotal": amountTotal,
   

    };
  }

  String toJsonString() {
    return jsonEncode({
       "id": id,
      "name": name,
      "amountTotal": amountTotal,

    });
  }

  String toPrintableString() {
    return "{"
          "id: $id,"
      "name: $name,"
      "amountTotal: $amountTotal,"

        "}";
  }

  static List<Sale> fromJsonStringListToCustomerList(String ListOfJsonString) {
    List listOfJson = jsonDecode(ListOfJsonString);
    List<Sale> listOfUsers = [];

    for (var element in listOfJson) {
      listOfUsers.add(Sale.fromJson(element));
    }
    return listOfUsers;
  }

  static fromCustomerListToJsonList(List<Sale> ListOfSale) {
    List listOfUsers = [];

    for (var element in ListOfSale) {
      listOfUsers.add(element.toJson());
    }
    return listOfUsers;
  }

  static fromCustomerListToJsonListString(List<Sale> ListOfSale) {
    List listOfCustomer = [];

    for (var element in ListOfSale) {
      listOfCustomer.add(element.toJson());
    }
    return jsonEncode(listOfCustomer);
  }

  static String fromCustomerListtoPrintableString(
      List<Sale> ListOfSale) {
    String listOfProduct = "[";
    for (Sale element in ListOfSale) {
      listOfProduct += "${element.toPrintableString()},";
    }
    listOfProduct += "]";
    return listOfProduct;
  }
}