import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/services/services.dart';

class AuthService extends ChangeNotifier {
  bool _IsLoggerInd = false;
  User? _user;
  String? token;

  bool get authentificated => _IsLoggerInd;
  User get user => _user!;
  Servidor servidor = Servidor();

  Future<String> login(
      String email, String password, String device_name) async {
    final response =
        await http.post(Uri.parse('${servidor.baseUrl}/sanctum/token'),
            body: ({
              'email': email,
              'password': password,
              'device_name': device_name,
            }));
    if (response.statusCode == 200) {
      String token = response.body.toString();
      return 'correcto';
    } else {
      return 'incorrecto';
    }
  }
}
