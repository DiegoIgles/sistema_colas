class CitaLaboratorio {
  final int id;
  final int centroMedicoId;
  final int grupoId;
  final String fecha;
  final String hora;
  final int cuposDisponibles;

  CitaLaboratorio({
    required this.id,
    required this.centroMedicoId,
    required this.grupoId,
    required this.fecha,
    required this.hora,
    required this.cuposDisponibles,
  });

  factory CitaLaboratorio.fromJson(Map<String, dynamic> json) {
    return CitaLaboratorio(
      id: json['id'],
      centroMedicoId: json['centro_medico_id'],
      grupoId: json['grupo_id'],
      fecha: json['fecha'],
      hora: json['hora'],
      cuposDisponibles: json['cupos_disponibles'],
    );
  }
}
