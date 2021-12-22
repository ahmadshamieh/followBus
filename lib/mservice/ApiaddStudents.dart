import 'dart:convert';
import 'package:followbus/model/modelLogin.dart';
import 'package:followbus/model/modelStudentAdd.dart';
import 'package:http/http.dart' as http;

Future<studentData> createStudents(String name, String latitude,
    String longitude, String location, String classR, String phone) async {
  final response = await http.post(
    Uri.https('followbus3.000webhostapp.com', 'index.php'),
    body: <String, String>{
      'createStudent': "1",
      'name': name.trim(),
      'latitude': latitude.trim(),
      'longitude': longitude.trim(),
      'location': location.trim(), //imp
      'class': classR.trim(),
      'phone': phone.trim(),
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return studentData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Conniction Erorr');
  }
}
