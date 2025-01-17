import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/models/laboratorio.dart';
import 'package:mi_primera_app/services/server.dart';

class ServicioLaboratorio {
  final Servidor servidor = Servidor();

  // Método para obtener servicios con POST
  Future<List<Laboratorio>> obtenerServiciosLaboratorio() async {
    final url =
        Uri.parse('${servidor.baseUrl}/laboratorios'); // Endpoint de tu API

    try {
      final response = await http.get(url);

      // print("Respuesta de la API: ${response.body}");

      // Imprime la respuesta para verificar el contenido
      if (response.statusCode == 200) {
        // Decodificar el JSON recibido
        final List<dynamic> data = jsonDecode(response.body);

        // Convertir el JSON en una lista de objetos Servicio
        final List<Laboratorio> laboratorios =
            data.map((json) => Laboratorio.fromJson(json)).toList();

        return laboratorios;
      } else {
        throw Exception(
            'Error al obtener los servicios: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
