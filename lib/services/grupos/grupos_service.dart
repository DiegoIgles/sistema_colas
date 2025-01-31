import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/models/grupo.dart'; // Asegúrate de tener el modelo Grupo importado
import 'package:mi_primera_app/services/server.dart'; // Asegúrate de que la clase Servidor esté configurada correctamente

class ServicioGrupo {
  final Servidor servidor = Servidor();

  // Método para obtener los grupos por servicio con POST
  Future<List<Grupo>> obtenerGruposPorServicio(int servicioId) async {
    final url = Uri.parse(
        '${servidor.baseUrl}/grupos-con-laboratorios'); // Endpoint de tu API

    try {
      // Crear el cuerpo de la solicitud con el ID del servicio
      final body = jsonEncode({"solservicio_id": servicioId});

      // Cabeceras necesarias (puedes agregar más si tu API las requiere)
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // Imprime el cuerpo de la solicitud para verificar
      // print("Enviando solicitud con el cuerpo: $body");

      // Hacer la solicitud POST
      final response = await http.post(url, headers: headers, body: body);

      // Imprime la respuesta para verificar el contenido
      // print("Respuesta de la API: ${response.body}");

      if (response.statusCode == 200) {
        // Decodificar el JSON recibido
        final List<dynamic> data = jsonDecode(response.body);

        // Convertir el JSON en una lista de objetos Grupo
        final List<Grupo> grupos =
            data.map((json) => Grupo.fromJson(json)).toList();

        return grupos;
      } else {
        throw Exception(
            'Error al obtener los grupos: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
