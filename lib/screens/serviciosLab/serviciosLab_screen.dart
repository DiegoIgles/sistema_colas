import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/serviciolab.dart';
import 'package:mi_primera_app/services/serviciolab/serviciolab_service.dart';
import 'package:mi_primera_app/screens/centros_medicos/centros_medicos_screen.dart'; // Importa la pantalla de centros médicos

class ServiciosLabScreen extends StatelessWidget {
  final int servicioId;

  const ServiciosLabScreen({super.key, required this.servicioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laboratorios del Servicio',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<ServicioLab>>(
        future: ServicioLabApi().obtenerServicioslabPorServicio(servicioId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final serviciosLab = snapshot.data ?? [];

          if (serviciosLab.isEmpty) {
            return const Center(
              child: Text('No hay laboratorios para este servicio.'),
            );
          }

          return ListView.builder(
            itemCount: serviciosLab.length,
            itemBuilder: (context, index) {
              final servicioLab = serviciosLab[index];
              return ListTile(
                title: Text(servicioLab.laboratorioNombre),
                subtitle: Text('ID: ${servicioLab.laboratorioId}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed: () {
                    // Navegar a la pantalla de centros médicos pasando el ID del laboratorio
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CentrosMedicosScreen(
                          laboratorioId: servicioLab.laboratorioId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
