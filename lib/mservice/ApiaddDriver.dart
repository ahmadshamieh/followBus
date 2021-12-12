import 'dart:convert';
import 'package:followbus/model/modelDriverData.dart';
import 'package:followbus/model/modelLogin.dart';
import 'package:followbus/model/modelStudentAdd.dart';
import 'package:http/http.dart' as http;

Future<DriverData> createDriver(String email, String password, String name,
    String phone, String location, String busNumber) async {
  final response = await http.post(
    Uri.https('followbus3.000webhostapp.com', 'index.php'),
    body: <String, String>{
      'createDriver': "1",
      'email': email.trim(),
      'location': location.trim(),
      'phone': phone.trim(),
      'name': name.trim(),
      'password': password.trim(),
      'busNumber': busNumber.trim(),
    },
  );

  print(response.body);
  if (response.statusCode == 200) {
    return DriverData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Conniction Erorr');
  }
}
