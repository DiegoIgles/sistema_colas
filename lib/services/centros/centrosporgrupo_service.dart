import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/models/centros.dart'; // Asegúrate de tener el modelo de CentroMedico
import 'package:mi_primera_app/services/server.dart';

class ServicioCentroPorGrupo {
  final Servidor servidor = Servidor();

  // Método para obtener centros médicos por grupo
  Future<List<Centros>> obtenerCentrosPorGrupo(int grupoId) async {
    final url = Uri.parse(
        '${servidor.baseUrl}/centros-medicos-por-grupo'); // Cambia a tu endpoint

    try {
      // Crear el cuerpo de la solicitud con el ID del grupo
      final body = jsonEncode({"grupo_id": grupoId});

      // Cabeceras necesarias
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // Hacer la solicitud POST
      final response = await http.post(url, headers: headers, body: body);

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
