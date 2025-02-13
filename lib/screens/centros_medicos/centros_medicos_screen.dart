import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/centros.dart'; // Modelo de CentroMedico
import 'package:mi_primera_app/services/centros/centros_service.dart'; // Servicio para obtener los centros médicos
import 'package:mi_primera_app/screens/grupos/gruposLab_screen.dart'; // Importamos la pantalla de grupos por servicio

class CentrosMedicosScreen extends StatefulWidget {
  final int userId;
  final int servicioId;

  const CentrosMedicosScreen({
    super.key,
    required this.userId,
    required this.servicioId,
  });

  @override
  _CentrosMedicosScreenState createState() => _CentrosMedicosScreenState();
}

class _CentrosMedicosScreenState extends State<CentrosMedicosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Centros Médicos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Centros>>(
        future: ServicioCentrosMedicos()
            .obtenerTodosLosCentros(), // Llamada al servicio para obtener todos los centros
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final centrosMedicos = snapshot.data ?? [];

          if (centrosMedicos.isEmpty) {
            return const Center(
              child: Text('No hay centros médicos disponibles.'),
            );
          }

          return ListView.builder(
            itemCount: centrosMedicos.length,
            itemBuilder: (context, index) {
              final centroMedico = centrosMedicos[index];

              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    centroMedico.nombre,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // subtitle: Text(
                  //   'ID: ${centroMedico.id}',
                  //   style: TextStyle(color: Colors.grey.shade600),
                  // ),
                  trailing: IconButton(
                    icon:
                        const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                    onPressed: () {
                      // Navegar a la pantalla de grupos por servicio pasando el centroMedicoId
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GruposPorServicioScreen(
                            servicioId: widget.servicioId,
                            userId: widget.userId,
                            centroMedicoId:
                                centroMedico.id, // Pasamos el centroMedicoId
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
