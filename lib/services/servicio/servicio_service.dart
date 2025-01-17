import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/models/servicio.dart';
import 'package:mi_primera_app/services/server.dart';

class ServicioApi {
  final Servidor servidor = Servidor();

  // Método para obtener servicios con POST
  Future<List<Servicio>> obtenerServiciosPorUsuario(int userId) async {
    final url = Uri.parse(
        '${servidor.baseUrl}/servicios/id_afiliado'); // Endpoint de tu API

    try {
      // Crear el cuerpo de la solicitud con el ID del usuario
      final body = jsonEncode({"afiliado_id": userId});

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
      //print("Respuesta de la API: ${response.body}");

      if (response.statusCode == 200) {
        // Decodificar el JSON recibido
        final List<dynamic> data = jsonDecode(response.body);

        // Convertir el JSON en una lista de objetos Servicio
        final List<Servicio> servicios =
            data.map((json) => Servicio.fromJson(json)).toList();

        return servicios;
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
