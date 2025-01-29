import 'package:flutter/material.dart';
import 'package:mi_primera_app/components/utils/sidebart.dart';
import 'package:mi_primera_app/models/servicio.dart';
import 'package:mi_primera_app/screens/serviciosLab/serviciosLab_screen.dart';
import 'package:mi_primera_app/services/servicio/servicio_service.dart';

class ServiciosScreen extends StatelessWidget {
  final int userId;
  const ServiciosScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
        title: const Text(
          'Mis Solicitudes',
          style: TextStyle(color: Colors.white),
        ),
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
              return ListTile(
                title: Text('ID: ${servicio.id}'),
                subtitle: Text(
                    'Afiliado ID: ${servicio.afiliadoId}\nCreado: ${servicio.createdAt.toLocal()}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ServiciosLabScreen(servicioId: servicio.id),
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
