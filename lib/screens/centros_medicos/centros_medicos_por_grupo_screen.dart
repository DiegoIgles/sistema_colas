// import 'package:flutter/material.dart';
// import 'package:mi_primera_app/models/centros.dart'; // El modelo de CentroMedico
// import 'package:mi_primera_app/services/centros/centrosporgrupo_service.dart'; // El servicio para obtener los centros médicos
// import 'package:mi_primera_app/screens/citaLab/disponibilidad_screen.dart'; // Importamos la pantalla de disponibilidad
// import 'package:intl/intl.dart'; // Para formatear la fecha

// class CentrosMedicosPorGrupoScreen extends StatefulWidget {
//   final int grupoId;
//   final int userId; // Añadir el userId aquí
//   final int servicioId; // Añadir el userId aquí

//   const CentrosMedicosPorGrupoScreen({
//     super.key,
//     required this.grupoId,
//     required this.userId,
//     required this.servicioId, // Recibir el userId aquí
//   });

//   @override
//   _CentrosMedicosPorGrupoScreenState createState() =>
//       _CentrosMedicosPorGrupoScreenState();
// }

// class _CentrosMedicosPorGrupoScreenState
//     extends State<CentrosMedicosPorGrupoScreen> {
//   late TextEditingController _fechaController;
//   String _fechaSeleccionada = ""; // Fecha por defecto (puedes cambiarla)

//   @override
//   void initState() {
//     super.initState();
//     _fechaController = TextEditingController(text: _fechaSeleccionada);
//   }

//   // Función para abrir el selector de fecha
//   Future<void> _seleccionarFecha(BuildContext context) async {
//     DateTime? fechaSeleccionada = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (fechaSeleccionada != null) {
//       // Actualizar la fecha seleccionada
//       setState(() {
//         _fechaSeleccionada = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
//         _fechaController.text =
//             _fechaSeleccionada; // Actualizamos el controlador del TextField
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Centros Médicos por Grupo',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.teal, // Cambiar el color del AppBar
//       ),
//       body: FutureBuilder<List<Centros>>(
//         future: ServicioCentroPorGrupo().obtenerCentrosPorGrupo(widget.grupoId),
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
//               child: Text('No hay centros médicos para este grupo.'),
//             );
//           }

//           return Column(
//             children: [
//               // TextField para mostrar y seleccionar la fecha
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: GestureDetector(
//                   onTap: () => _seleccionarFecha(context),
//                   child: AbsorbPointer(
//                     child: TextField(
//                       controller: _fechaController,
//                       decoration: InputDecoration(
//                         labelText: 'Seleccionar fecha',
//                         labelStyle: TextStyle(color: Colors.teal),
//                         filled: true,
//                         fillColor: Colors.teal.shade50,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                         suffixIcon: Icon(Icons.calendar_today, color: Colors.teal),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Lista de centros médicos
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: centrosMedicos.length,
//                   itemBuilder: (context, index) {
//                     final centroMedico = centrosMedicos[index];

//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15), // Bordes redondeados
//                       ),
//                       elevation: 5,
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(16),
//                         title: Text(
//                           centroMedico.nombre,
//                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                         ),
//                         subtitle: Text(
//                           'ID: ${centroMedico.id}',
//                           style: TextStyle(color: Colors.grey.shade600),
//                         ),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.schedule, color: Colors.teal),
//                           onPressed: () {
//                             // Navegar a la pantalla de disponibilidad
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DisponibilidadScreen(
//                                   centroMedicoId: centroMedico.id,
//                                   grupoId: widget.grupoId,
//                                   fecha: _fechaSeleccionada, // Usamos la fecha seleccionada
//                                   afiliadoId: widget.userId,
//                                   servicioId: widget.servicioId, 
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
