import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/services/server.dart'; // Tu clase de servidor

class MisReservasService {
  final Servidor servidor = Servidor();

  // Método para obtener las reservas
  Future<List<Map<String, dynamic>>> obtenerReservas(int afiliadoId) async {
    final url = Uri.parse('${servidor.baseUrl}/reservas');
    final response = await http.post(
      url,
      body: jsonEncode({"afiliado_id": afiliadoId}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((reserva) => reserva as Map<String, dynamic>).toList();
    } else {
      throw Exception("Error al obtener las reservas");
    }
  }

  // Método para eliminar una reserva
  Future<Map<String, dynamic>> eliminarReserva(
      int afiliadoId, int idReserva) async {
    final url = Uri.parse('${servidor.baseUrl}/eliminar-reserva');
    final response = await http.post(
      url,
      body: jsonEncode({
        "afiliado_id": afiliadoId,
        "id_reserva": idReserva,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // print('Respuesta del servidor: ${response.body}');

      return jsonDecode(response.body); // Devuelve la respuesta
    } else {
      throw Exception("Error al eliminar la reserva");
    }
  }
}
