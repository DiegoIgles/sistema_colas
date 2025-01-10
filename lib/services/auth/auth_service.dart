import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/models.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  bool _IsLoggerInd = false;
  User? _user;
  String? token;

  bool get authentificated => _IsLoggerInd;
  User get user => _user!;

  Future<String> login(
      String email, String password, String device_name) async {
    final response =
        http.post(Uri.parse('http://127.0.0.1:8000/api/sanctum/token'), body: [
      {
        'email': email,
        'password': password,
        'device_name': device_name,
      }
    ]);

    return '';
  }
}
