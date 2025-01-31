// import 'package:flutter/material.dart';
// import 'package:mi_primera_app/services/centros/centrosporgrupo_service.dart'; // Asegúrate de tener el servicio adecuado para obtener los centros por grupo

// class CentrosMedicosScreen extends StatelessWidget {
//   final int grupoId; // Cambié laboratorioId a grupoId

//   const CentrosMedicosScreen({super.key, required this.grupoId}); // Recibe grupoId en lugar de laboratorioId

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Centros Médicos por Grupo',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: FutureBuilder(
//         future: ServicioGrupoApi().obtenerCentrosPorGrupo(grupoId), // Cambié la función para que utilice el grupoId
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           final centrosMedicos = snapshot.data ?? [];

//           if (centrosMedicos.isEmpty) {
//             return const Center(
//               child: Text('No hay centros médicos disponibles para este grupo.'),
//             );
//           }

//           return ListView.builder(
//             itemCount: centrosMedicos.length,
//             itemBuilder: (context, index) {
//               final centroMedico = centrosMedicos[index];
//               return ListTile(
//                 title: Text(centroMedico.nombre), // Muestra el nombre del centro médico
//                 subtitle: Text(centroMedico.direccion), // Muestra la dirección del centro médico
//                 trailing: IconButton(
//                   icon: Icon(Icons.add_box),
//                   onPressed: () {
//                     // Aquí puedes agregar la funcionalidad para navegar a otra pantalla o realizar alguna acción
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
