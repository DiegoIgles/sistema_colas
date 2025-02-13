class Laboratorio {
  final int id;
  final String nombre;

  Laboratorio({required this.id, required this.nombre});

  factory Laboratorio.fromJson(Map<String, dynamic> json) {
    return Laboratorio(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
}
