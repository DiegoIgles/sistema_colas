// class User {
//   int id;
//   String name;
//   String email;
//   dynamic emailVerifiedAt;
//   DateTime createdAt;
//   DateTime updatedAt;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.emailVerifiedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   User.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         name = json['name'],
//         email = json['email'],
//         emailVerifiedAt = json['email_verified_at'],
//         createdAt = DateTime.parse(json['created_at']),
//         updatedAt = DateTime.parse(json['updated_at']);
// }

class User {
  int id;
  String matricula;
  String paterno;
  String materno;
  String nombre;
  String hclinica;
  String empresa;
  String tafiliado;
  String activo;
  String grupofam;
  int relacion;
  String fcesantia;
  DateTime uaporte;
  int eclasifica;
  int nominal;
  String npatronal;
  int mora;
  String fretiro;
  int remoteId;
  int filialId;
  int filialAdmId;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.matricula,
    required this.paterno,
    required this.materno,
    required this.nombre,
    required this.hclinica,
    required this.empresa,
    required this.tafiliado,
    required this.activo,
    required this.grupofam,
    required this.relacion,
    required this.fcesantia,
    required this.uaporte,
    required this.eclasifica,
    required this.nominal,
    required this.npatronal,
    required this.mora,
    required this.fretiro,
    required this.remoteId,
    required this.filialId,
    required this.filialAdmId,
    required this.createdAt,
    required this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        matricula = json['matricula'],
        paterno = json['paterno'],
        materno = json['materno'],
        nombre = json['nombre'],
        hclinica = json['hclinica'],
        empresa = json['empresa'],
        tafiliado = json['tafiliado'],
        activo = json['activo'],
        grupofam = json['grupofam'],
        relacion = json['relacion'],
        fcesantia = json['fcesantia'],
        uaporte = DateTime.parse(json['uaporte']),
        eclasifica = json['eclasifica'],
        nominal = json['nominal'],
        npatronal = json['npatronal'],
        mora = json['mora'],
        fretiro = json['fretiro'],
        remoteId = json['remote_id'],
        filialId = json['filial_id'],
        filialAdmId = json['filial_adm_id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);
}
