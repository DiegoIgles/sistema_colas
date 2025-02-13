import 'package:mi_primera_app/models/laboratorio.dart';

class Grupo {
  final int id;
  final String nombre;
  final List<Laboratorio> laboratorios;

  Grupo({
    required this.id,
    required this.nombre,
    required this.laboratorios,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) {
    // Mapeamos los laboratorios correctamente
    var laboratoriosJson = json['laboratorios'] as List;
    List<Laboratorio> laboratoriosList = laboratoriosJson
        .map((laboratorioJson) => Laboratorio.fromJson(laboratorioJson))
        .toList();

    return Grupo(
      id: json['id'],
      nombre: json['nombre'],
      laboratorios: laboratoriosList,
    );
  }
}
