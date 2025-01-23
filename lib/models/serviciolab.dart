class ServicioLab {
  int id;
  int solservicioId;
  int laboratorioId;
  String laboratorioNombre;

  ServicioLab({
    required this.id,
    required this.solservicioId,
    required this.laboratorioId,
    required this.laboratorioNombre,
  });

  ServicioLab.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        solservicioId = json['solservicio_id'],
        laboratorioId = json['laboratorio_id'],
        laboratorioNombre = json['laboratorio_nombre'];
}
