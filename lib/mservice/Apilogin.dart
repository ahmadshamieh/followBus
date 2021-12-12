import 'dart:convert';
import 'package:followbus/model/modelLogin.dart';
import 'package:http/http.dart' as http;

Future<loginData> createAlbum(String email, String Pass) async {
  final response = await http.post(
    Uri.https('followbus3.000webhostapp.com', 'index.php'),
    body: <String, String>{
      'login': "1",
      'email': email.trim(),
      'password': Pass.trim(),
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return loginData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Conniction Erorr');
  }
}
