import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/models/centros.dart'; // Asegúrate de tener el modelo CentroMedico configurado
import 'package:mi_primera_app/services/server.dart'; // Clase Servidor para la base URL

class ServicioCentrosMedicos {
  final Servidor servidor = Servidor();

  // Método para obtener todos los centros médicos
  Future<List<Centros>> obtenerTodosLosCentros() async {
    final url = Uri.parse('${servidor.baseUrl}/centros'); // Endpoint de la API

    try {
      // Cabeceras necesarias para la solicitud GET
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // Hacer la solicitud GET
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Decodificar el JSON recibido
        final List<dynamic> data = jsonDecode(response.body);

        // Convertir el JSON en una lista de objetos CentroMedico
        final List<Centros> centros =
            data.map((json) => Centros.fromJson(json)).toList();

        return centros;
      } else {
        throw Exception(
            'Error al obtener los centros médicos: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
