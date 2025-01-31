import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/grupo.dart'; // Modelo de Grupo
import 'package:mi_primera_app/screens/centros_medicos/centros_medicos_por_grupo_screen.dart';
import 'package:mi_primera_app/services/grupos/grupos_service.dart'; // Servicio de Grupo

class GruposPorServicioScreen extends StatelessWidget {
  final int servicioId;

  const GruposPorServicioScreen({super.key, required this.servicioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grupos del Servicio',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Grupo>>(
        future: ServicioGrupo().obtenerGruposPorServicio(
            servicioId), // Usamos el servicio para obtener los grupos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final grupos = snapshot.data ?? [];

          if (grupos.isEmpty) {
            return const Center(
              child: Text('No hay grupos para este servicio.'),
            );
          }

          return ListView.builder(
            itemCount: grupos.length,
            itemBuilder: (context, index) {
              final grupo = grupos[index];
              return ListTile(
                title: Text(grupo.nombre), // Mostramos el nombre del grupo
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Mostramos todos los laboratorios asociados a este grupo
                    for (var laboratorio in grupo.laboratorios)
                      Text('- ${laboratorio.nombre}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CentrosMedicosPorGrupoScreen(
                          grupoId: grupo.id,
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
