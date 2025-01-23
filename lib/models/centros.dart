class Centros {
  int id;
  String nombre;
  String direccion;

  Centros({
    required this.id,
    required this.nombre,
    required this.direccion,
  });

  Centros.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        direccion = json['direccion'];
}
