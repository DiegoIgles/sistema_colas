// class Grupo {
//   final int id;
//   final String nombre;

//   Grupo({required this.id, required this.nombre});

//   // Factory constructor para crear una instancia de Grupo desde JSON
//   factory Grupo.fromJson(Map<String, dynamic> json) {
//     return Grupo(
//       id: json['id'],
//       nombre: json['nombre'],
//     );
//   }
// }
import 'package:mi_primera_app/models/laboratorio.dart';

class Grupo {
  final int id;
  final String nombre;
  final List<Laboratorio> laboratorios;

  Grupo({required this.id, required this.nombre, required this.laboratorios});

  // Factory constructor para crear una instancia de Grupo desde JSON
  factory Grupo.fromJson(Map<String, dynamic> json) {
    var laboratoriosJson = json['laboratorios'] as List<dynamic>;
    List<Laboratorio> laboratoriosList = laboratoriosJson
        .map((labJson) => Laboratorio.fromJson(labJson))
        .toList();

    return Grupo(
      id: json['id'],
      nombre: json['nombre'],
      laboratorios: laboratoriosList,
    );
  }
}
