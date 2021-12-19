class StudentListData {
  bool error;
  String message;
  List<DataS> data;

  StudentListData({this.error, this.message, this.data});

  StudentListData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<DataS>();
      json['data'].forEach((v) {
        data.add(new DataS.fromJson(v));
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

class DataS {
  String id;
  String name;
  String latitude;
  String longitude;
  String location;
  String classR;
  String phone;
  dynamic distance;

  DataS(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.location,
      this.classR,
      this.phone});

  DataS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    classR = json['class'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['class'] = this.classR;
    data['phone'] = this.phone;
    return data;
  }

  setDistance(dynamic d) {
    this.distance = d;
  }
}
