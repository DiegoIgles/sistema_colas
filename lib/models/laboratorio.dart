class Laboratorio {
  int id;
  String nombre;

  Laboratorio({
    required this.id,
    required this.nombre,
  });

  Laboratorio.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'];
}
