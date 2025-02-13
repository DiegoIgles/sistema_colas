import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/servicio.dart';
import 'package:mi_primera_app/screens/centros_medicos/centros_medicos_screen.dart';
import 'package:mi_primera_app/services/servicio/servicio_service.dart';

class ServiciosScreen extends StatelessWidget {
  final int userId;
  const ServiciosScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Solicitudes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // Puedes cambiar el color de la appBar
      ),
      body: FutureBuilder<List<Servicio>>(
        future: ServicioApi().obtenerServiciosPorUsuario(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final servicios = snapshot.data ?? [];

          return ListView.builder(
            itemCount: servicios.length,
            itemBuilder: (context, index) {
              final servicio = servicios[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    'Nro: ${servicio.id}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Afiliado ID: ${servicio.afiliadoId}'),
                      const SizedBox(height: 8),
                      Text(
                        'Creado: ${servicio.createdAt.toLocal().toString().split(' ')[0]}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_box, color: Colors.teal),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CentrosMedicosScreen(
                            servicioId: servicio.id,
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
