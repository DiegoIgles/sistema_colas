import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/models/grupo.dart'; // Asegúrate de que el modelo Grupo esté correctamente importado
import 'package:mi_primera_app/services/server.dart'; // Asegúrate de que la clase Servidor esté configurada correctamente

class GruposCentroMedicosService {
  final Servidor servidor = Servidor();

  // Método para obtener los grupos por servicio con POST
  Future<List<Grupo>> obtenerGruposPorCentroMedico(
      int centroMedicoId, int solservicioId) async {
    final url = Uri.parse(
        '${servidor.baseUrl}/grupos-por-centro-medico'); // Endpoint de tu API

    try {
      // Crear el cuerpo de la solicitud con los IDs del centro médico y solservicio
      final body = jsonEncode({
        "solservicio_id": solservicioId,
        "centro_medico_id": centroMedicoId,
      });

      // Cabeceras necesarias (puedes agregar más si tu API las requiere)
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // print('Enviando solicitud POST a: \$url');
      // print('Cuerpo de la solicitud: \$body');

      // Hacer la solicitud POST
      final response = await http.post(url, headers: headers, body: body);
      // print('Respuesta completa recibida: ${response.body}');
      if (response.statusCode == 200) {
        // Verifica si la respuesta está vacía
        if (response.body.isEmpty) {
          return []; // Retornar una lista vacía si la respuesta está vacía
        }

        // Decodificar el JSON recibido
        final dynamic data = jsonDecode(response.body);

        // Verifica si la respuesta es una lista de objetos
        if (data is List) {
          final List<Grupo> grupos =
              data.map((json) => Grupo.fromJson(json)).toList();
          return grupos;
        } else {
          return []; // Si no es una lista, retornar lista vacía
        }
      } else {
        throw Exception(
            'Error al obtener los grupos: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return []; // Retornar lista vacía en caso de error
    }
  }
}
