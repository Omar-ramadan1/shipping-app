class Userdata {
  String? jsonrpc;
  Result? result;

  Userdata({this.jsonrpc,  this.result});

  Userdata.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Result? result;
  String? message;
  int? code;

  Result({this.result, this.message, this.code});

  Result.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Resultt {
  int? userId;
  int? partnerId;
  String? userName;
  String? userEmail;
  String? userPhoto;
  String? userPhone;

  Resultt(
      {this.userId,
      this.partnerId,
      this.userName,
      this.userEmail,
      this.userPhoto,
      this.userPhone});

  Resultt.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    partnerId = json['partner_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhoto = json['user_photo'];
    userPhone = json['user_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['partner_id'] = this.partnerId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_photo'] = this.userPhoto;
    data['user_phone'] = this.userPhone;
    return data;
  }
}
