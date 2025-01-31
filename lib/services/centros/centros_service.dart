// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:mi_primera_app/models/centros.dart';
// import 'package:mi_primera_app/services/server.dart';

// class ServicioCentro {
//   final Servidor servidor = Servidor();

//   // Método para obtener servicioslab con POST
//   Future<List<Centros>> obtenerServiciosCentros(int laboratorioId) async {
//     final url = Uri.parse(
//         '${servidor.baseUrl}/laboratorios/centros-medicos'); // Endpoint de tu API

//     try {
//       // Crear el cuerpo de la solicitud con el ID del usuario
//       final body = jsonEncode({"laboratorio_id": laboratorioId});

//       // Cabeceras necesarias (puedes agregar más si tu API las requiere)
//       final headers = {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//       };
//       // Imprime el cuerpo de la solicitud para verificar
//       // print("Enviando solicitud con el cuerpo: $body");

//       // Hacer la solicitud POST
//       final response = await http.post(url, headers: headers, body: body);

//       // Imprime la respuesta para verificar el contenido
//       // print("Respuesta de la API: ${response.body}");

//       if (response.statusCode == 200) {
//         // Decodificar el JSON recibido
//         final List<dynamic> data = jsonDecode(response.body);

//         // Convertir el JSON en una lista de objetos Servicio
//         final List<Centros> serviciosCentros =
//             data.map((json) => Centros.fromJson(json)).toList();

//         return serviciosCentros;
//       } else {
//         throw Exception(
//             'Error al obtener los servicioslab: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//       return [];
//     }
//   }
// }
