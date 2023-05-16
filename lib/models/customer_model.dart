import 'dart:convert';

class Customer {
  int? id;
  String? name;
  String? email;
  String? sLastUpdate;
  String? image1920;
  int? customerRank;
  String? mobile;
  String? phone;
  String? website;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.sLastUpdate,
      this.image1920,
      this.customerRank,
      this.mobile,
      this.phone,
      this.website});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'].toString();
    sLastUpdate = json['__last_update'];
    image1920 = json['image_1920'].toString();
    customerRank = json['customer_rank'];
    mobile = json['mobile'].toString();
    phone = json['phone'].toString();
    website = json['website'].toString();
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "__last_update": sLastUpdate,
      "image_1920": image1920,
      "customer_rank": customerRank,
      "mobile": mobile,
      "phone": phone,
      "website": website,
    };
  }

  String toJsonString() {
    return jsonEncode({
      "id": id,
      "name": name,
      "email": email,
      "__last_update": sLastUpdate,
      "image_1920": image1920,
      "customer_rank": customerRank,
      "mobile": mobile,
      "phone": phone,
      "website": website,
    });
  }

  String toPrintableString() {
    return "{"
        "id : $id,"
        "name: $name,"
        "email:$email,"
        "__last_update: $sLastUpdate,"
        "image_1920: $image1920,"
        "customer_rank: $customerRank,"
        "mobile: $mobile,"
        "phone: $phone,"
        "website: $website,"
        "}";
  }

  static List<Customer> fromJsonStringListToCustomerList(String ListOfJsonString) {
    List listOfJson = jsonDecode(ListOfJsonString);
    List<Customer> listOfUsers = [];

    for (var element in listOfJson) {
      listOfUsers.add(Customer.fromJson(element));
    }
    return listOfUsers;
  }

  static fromCustomerListToJsonList(List<Customer> ListOfCustomer) {
    List listOfUsers = [];

    for (var element in ListOfCustomer) {
      listOfUsers.add(element.toJson());
    }
    return listOfUsers;
  }

  static fromCustomerListToJsonListString(List<Customer> ListOfCustomer) {
    List listOfCustomer = [];

    for (var element in ListOfCustomer) {
      listOfCustomer.add(element.toJson());
    }
    return jsonEncode(listOfCustomer);
  }

  static String fromCustomerListtoPrintableString(
      List<Customer> ListOfCustomer) {
    String listOfCustomer = "[";
    for (Customer element in ListOfCustomer) {
      listOfCustomer += "${element.toPrintableString()},";
    }
    listOfCustomer += "]";
    return listOfCustomer;
  }
}
