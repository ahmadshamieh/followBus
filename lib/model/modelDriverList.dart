class DriverListData {
  bool error;
  String message;
  List<Data> data;

  DriverListData({this.error, this.message, this.data});

  DriverListData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String name;
  String phone;
  String location;
  String busNumber;
  String email;
  String password;
  String isAdmin;

  Data(
      {this.id,
      this.name,
      this.phone,
      this.location,
      this.busNumber,
      this.email,
      this.password,
      this.isAdmin});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    location = json['location'];
    busNumber = json['busNumber'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['busNumber'] = this.busNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}
