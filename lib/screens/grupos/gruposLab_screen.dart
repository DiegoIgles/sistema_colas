import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/grupo.dart'; // Modelo de Grupo
import 'package:mi_primera_app/screens/centros_medicos/centros_medicos_por_grupo_screen.dart';
import 'package:mi_primera_app/services/grupos/grupos_service.dart'; // Servicio de Grupo

class GruposPorServicioScreen extends StatelessWidget {
  final int servicioId;
  final int userId; // Añadir userId aquí

  const GruposPorServicioScreen({
    super.key,
    required this.servicioId,
    required this.userId, // Recibir el userId aquí
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grupos del Servicio',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // Color atractivo para la appBar
      ),
      body: FutureBuilder<List<Grupo>>(
        future: ServicioGrupo().obtenerGruposPorServicio(servicioId), // Usamos el servicio para obtener los grupos
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
              child: Text(
                'No hay grupos para este servicio.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: grupos.length,
            itemBuilder: (context, index) {
              final grupo = grupos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    grupo.nombre,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Mostramos todos los laboratorios asociados a este grupo
                      for (var laboratorio in grupo.laboratorios)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '- ${laboratorio.nombre}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CentrosMedicosPorGrupoScreen(
                            grupoId: grupo.id,
                            userId: userId,
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
