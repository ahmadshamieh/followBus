import 'dart:convert';
import 'package:followbus/model/modelDriverList.dart';
import 'package:http/http.dart' as http;

Future<DriverListData> createDriverListData() async {
  final response = await http.post(
    Uri.https('followbus3.000webhostapp.com', '/'),
    body: <String, String>{
      'listDrivers': "1",
    },
  );
  print("listDrivers");
  print("//////////////////////////////");
  print(response.body);
  print("//////////////////////////////");
  if (response.statusCode == 200) {
    return DriverListData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Conniction Erorr');
  }
}
