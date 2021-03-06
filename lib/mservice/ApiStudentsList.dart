import 'dart:convert';
import 'package:followbus/model/modelStudentsList.dart';
import 'package:http/http.dart' as http;

Future<StudentListData> createStudentListData() async {
  final response = await http.post(
    Uri.https('followbus3.000webhostapp.com', '/'),
    body: <String, String>{
      'listStudents': "1",
    },
  );
  print("listStudents");
  print("//////////////////////////////");
  print(response.body);
  print("//////////////////////////////");
  if (response.statusCode == 200) {
    return StudentListData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Conniction Erorr');
  }
}
