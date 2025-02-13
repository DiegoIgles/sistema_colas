import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/cita_laboratorio.dart';
import 'package:mi_primera_app/services/citaLab/servicio_citas.dart';
import 'package:mi_primera_app/screens/reserva/reserva_screen.dart'; // Pantalla de reserva

class DisponibilidadScreen extends StatefulWidget {
  final int centroMedicoId;
  final int grupoId;
  final String fecha;
  final int afiliadoId; // Agregar afiliadoId aquí
  final int servicioId;
  const DisponibilidadScreen({
    Key? key,
    required this.centroMedicoId,
    required this.grupoId,
    required this.fecha,
    required this.afiliadoId,
    required this.servicioId, // Agregar afiliadoId
  }) : super(key: key);

  @override
  _DisponibilidadScreenState createState() => _DisponibilidadScreenState();
}

class _DisponibilidadScreenState extends State<DisponibilidadScreen> {
  final ServicioCitas servicioCitas = ServicioCitas();
  late Future<List<CitaLaboratorio>> futureCitas;

  @override
  void initState() {
    super.initState();
    futureCitas = servicioCitas.obtenerDisponibilidad(
      centroMedicoId: widget.centroMedicoId,
      grupoId: widget.grupoId,
      fecha: widget.fecha,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Disponibilidad de Citas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // Cambiar el color del AppBar
      ),
      body: FutureBuilder<List<CitaLaboratorio>>(
        future: futureCitas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("Error al cargar la disponibilidad"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay citas disponibles"));
          }

          final citas = snapshot.data!;

          return ListView.builder(
            itemCount: citas.length,
            itemBuilder: (context, index) {
              final cita = citas[index];

              return Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.2), // Sombra suave
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    "Hora: ${cita.hora}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Cupos disponibles: ${cita.cuposDisponibles}",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  trailing: Icon(
                    Icons.schedule,
                    color: Colors.teal, // Color del ícono
                    size: 28,
                  ),
                  onTap: () {
                    // Redirigir a la pantalla de reserva cuando se toca la cita
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservarCitacreen(
                          citaId: cita.id,
                          afiliadoId: widget.afiliadoId,
                          servicioId: widget.servicioId, // Pasamos el afiliadoId
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
