class Servicio {
  int id;
  int afiliadoId;
  DateTime createdAt;

  Servicio({
    required this.id,
    required this.afiliadoId,
    required this.createdAt,
  });

  // Constructor para crear el objeto desde un JSON
  Servicio.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        afiliadoId = json['afiliado_id'],
        createdAt = DateTime.parse(json['created_at']);
}
