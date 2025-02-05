import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/models/cita_laboratorio.dart';
import 'package:mi_primera_app/services/server.dart';

class ServicioCitas {
  final Servidor servidor = Servidor();

  Future<List<CitaLaboratorio>> obtenerDisponibilidad({
    required int centroMedicoId,
    required int grupoId,
    required String fecha,
  }) async {
    final url = Uri.parse('${servidor.baseUrl}/disponibilidad');

    try {
      final body = jsonEncode({
        "centro_medico_id": centroMedicoId,
        "grupo_id": grupoId,
        "fecha": fecha,
      });

      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CitaLaboratorio.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener disponibilidad: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
