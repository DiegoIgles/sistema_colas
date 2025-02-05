import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/services/server.dart'; // Tu clase de servidor

class ReservaService {
  final Servidor servidor = Servidor();

  // Método para realizar la reserva de cita
  Future<Map<String, dynamic>> reservarCita(
      int citaId, int afiliadoId, String telefono) async {
    final url =
        Uri.parse('${servidor.baseUrl}/reservar-cita'); // Endpoint de la API

    try {
      // Crear el cuerpo de la solicitud
      final body = jsonEncode({
        "cita_id": citaId,
        "afiliado_id": afiliadoId,
        "telefono": telefono,
      });

      // Cabeceras necesarias
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // Realizar la solicitud POST
      final response = await http.post(url, headers: headers, body: body);

      // Verificar si la respuesta fue exitosa
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Verificamos si la respuesta contiene la recomendación
        print("Respuesta completa: $responseData");

        return responseData; // Regresamos la respuesta completa
      } else {
        throw Exception('Error al reservar la cita: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return {'error': e.toString()};
    }
  }
}
