class Servicio {
  int id;
  int afiliadoId;
  int medicoId;
  DateTime createdAt;
  DateTime updatedAt;
  int consultaemergenciasId;
  dynamic consultavaloracionespecialistaId;
  dynamic pacienteotroseguroId;
  dynamic fechahoralabo;
  int nroasignadolabo;
  dynamic fechahorarx;
  dynamic nroasignadorx;
  dynamic fechahoragab;
  dynamic nroasignadogab;
  int centroSaludId;
  String procedencia;
  int especialidadId;
  dynamic tabladereferenciaId;
  dynamic idtablareferencia;
  int centroproclabo;

  Servicio({
    required this.id,
    required this.afiliadoId,
    required this.medicoId,
    required this.createdAt,
    required this.updatedAt,
    required this.consultaemergenciasId,
    required this.consultavaloracionespecialistaId,
    required this.pacienteotroseguroId,
    required this.fechahoralabo,
    required this.nroasignadolabo,
    required this.fechahorarx,
    required this.nroasignadorx,
    required this.fechahoragab,
    required this.nroasignadogab,
    required this.centroSaludId,
    required this.procedencia,
    required this.especialidadId,
    required this.tabladereferenciaId,
    required this.idtablareferencia,
    required this.centroproclabo,
  });

  Servicio.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        afiliadoId = json['afiliado_id'],
        medicoId = json['medico_id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        consultaemergenciasId = json['consultaemergencias_id'],
        consultavaloracionespecialistaId =
            json['consultavaloracionespecialista_id'],
        pacienteotroseguroId = json['pacienteotroseguro_id'],
        fechahoralabo = json['fechahoralabo'],
        nroasignadolabo = json['nroasignadolabo'],
        fechahorarx = json['fechahorarx'],
        nroasignadorx = json['nroasignadorx'],
        fechahoragab = json['fechahoragab'],
        nroasignadogab = json['nroasignadogab'],
        centroSaludId = json['centro_salud_id'],
        procedencia = json['procedencia'],
        especialidadId = json['especialidad_id'],
        tabladereferenciaId = json['tabladereferencia_id'],
        idtablareferencia = json['idtablareferencia'],
        centroproclabo = json['centroproclabo'];
}
