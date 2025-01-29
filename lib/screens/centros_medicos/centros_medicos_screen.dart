import 'package:flutter/material.dart';
import 'package:mi_primera_app/services/centros/centros_service.dart';

class CentrosMedicosScreen extends StatelessWidget {
  final int laboratorioId;

  const CentrosMedicosScreen({super.key, required this.laboratorioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Centros Médicos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: ServicioCentro().obtenerServiciosCentros(laboratorioId),
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
              return ListTile(
                title: Text(centroMedico.nombre),
                subtitle: Text(centroMedico.direccion),
                trailing: IconButton(
                  icon: Icon(Icons.add_box),
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
