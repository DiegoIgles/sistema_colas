import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/services/server.dart'; // Tu clase de servidor

class RecomendacionService {
  final Servidor servidor = Servidor();

  Future<List<dynamic>> obtenerRecomendacionesPorSolservicio(
      int solservicioId) async {
    final url = Uri.parse('${servidor.baseUrl}/recomendaciones/solservicio');

    try {
      final body = jsonEncode({
        "solservicio_id": solservicioId,
      });

      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Verificar si la respuesta es un mapa y convertir sus valores en una lista
        if (responseData is Map<String, dynamic>) {
          return responseData.values.toList(); // Convertir el mapa a lista
        } else if (responseData is List<dynamic>) {
          return responseData; // Si ya es una lista, la devolvemos tal cual
        } else {
          throw Exception('Formato inesperado de la respuesta');
        }
      } else {
        throw Exception(
            'Error al obtener las recomendaciones: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
