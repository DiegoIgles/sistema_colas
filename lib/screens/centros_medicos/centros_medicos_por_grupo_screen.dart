import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/centros.dart'; // El modelo de CentroMedico
import 'package:mi_primera_app/services/centros/centrosporgrupo_service.dart'; // El servicio para obtener los centros médicos

class CentrosMedicosPorGrupoScreen extends StatelessWidget {
  final int grupoId;

  const CentrosMedicosPorGrupoScreen({super.key, required this.grupoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Centros Médicos por Grupo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Centros>>(
        future: ServicioCentroPorGrupo()
            .obtenerCentrosPorGrupo(grupoId), // Obtener centros por grupoId
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
              child: Text('No hay centros médicos para este grupo.'),
            );
          }

          return ListView.builder(
            itemCount: centrosMedicos.length,
            itemBuilder: (context, index) {
              final centroMedico = centrosMedicos[index];
              return ListTile(
                title: Text(
                    centroMedico.nombre), // Muestra el nombre del centro médico
                subtitle: Text('ID: ${centroMedico.id}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed: () {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
