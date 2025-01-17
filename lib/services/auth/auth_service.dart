import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/services/services.dart';

class AuthService extends ChangeNotifier {
  bool _IsLoggerInd = false;
  User? _user;
  String? _token;

  bool get authentificated => _IsLoggerInd;
  User get user => _user!;
  Servidor servidor = Servidor();

  Future<String> login(String matricula, String device_name) async {
    try {
      final response =
          await http.post(Uri.parse('${servidor.baseUrl}/sanctum/token'),
              body: ({
                'matricula': matricula,
                'device_name': device_name,
              }));
      if (response.statusCode == 200) {
        String token = response.body.toString();
        tryToken(token);
        return 'correcto';
      } else {
        return 'incorrecto';
      }
    } catch (e) {
      return 'hay un error';
    }
  }

  void tryToken(String? token) async {
    if (token == null) {
      return;
    } else {
      try {
        final response = await http.get(Uri.parse('${servidor.baseUrl}/user'),
            headers: {'Authorization': 'Bearer $token'});
        //print(response.body);
        _IsLoggerInd = true;
        _user = User.fromJson(jsonDecode(response.body));
        _token = token;

        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  void logout() async {
    try {
      final response = await http.get(
          Uri.parse('${servidor.baseUrl}/user/revoke'),
          headers: {'Authorization': 'Bearer $_token'});
      cleanUp();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void cleanUp() async {
    _user = null;
    _IsLoggerInd = false;
    _user = null;
    //TODO_cache del telefono
  }
}
