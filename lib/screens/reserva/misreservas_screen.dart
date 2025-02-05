import 'package:flutter/material.dart';
import 'package:mi_primera_app/services/reserva/misreserva_service.dart'; // Importar el servicio de reservas
import 'package:intl/intl.dart'; // Para comparar las fechas
import 'package:mi_primera_app/screens/screens.dart';

class MisReservasScreen extends StatefulWidget {
  final int afiliadoId;

  const MisReservasScreen({Key? key, required this.afiliadoId})
      : super(key: key);

  @override
  _MisReservasScreenState createState() => _MisReservasScreenState();
}

class _MisReservasScreenState extends State<MisReservasScreen> {
  late Future<List<Map<String, dynamic>>> futureReservas;
  final MisReservasService reservasService = MisReservasService();

  @override
  void initState() {
    super.initState();
    futureReservas = reservasService.obtenerReservas(widget.afiliadoId);
  }

  // Método para filtrar las reservas dentro de las dos semanas
  List<Map<String, dynamic>> _filtrarReservas(
      List<Map<String, dynamic>> reservas) {
    final DateTime now = DateTime.now();
    final DateTime twoWeeksFromNow = now.add(Duration(days: 14));

    return reservas.where((reserva) {
      final DateTime fechaCita =
          DateFormat('yyyy-MM-dd').parse(reserva['fecha_cita']);
      return fechaCita.isAfter(now) && fechaCita.isBefore(twoWeeksFromNow);
    }).toList();
  }

  // Método para eliminar la reserva
  void _eliminarReserva(int idReserva) async {
    try {
      final result =
          await reservasService.eliminarReserva(widget.afiliadoId, idReserva);

      // Verifica si el mensaje de respuesta contiene "Reserva eliminada con éxito"
      if (result != null &&
          result['message'] != null &&
          result['message']!.contains("Reserva eliminada con éxito")) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reserva eliminada con éxito')));

        setState(() {
          // Actualizamos la lista de reservas después de eliminar
          futureReservas = reservasService.obtenerReservas(widget.afiliadoId);
        });
      } else {
        // Si el mensaje no indica éxito, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar la reserva')));
      }
    } catch (e) {
      // Si ocurre un error, muestra el error
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar la reserva: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
        title: const Text(
          "Mis Reservas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // Estilo de AppBar
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Espera a que lleguen las reservas
        future: futureReservas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("No tienes reservas"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No tienes reservas"));
          }

          final reservas = snapshot.data!;
          final reservasFiltradas = _filtrarReservas(reservas);

          return ListView.builder(
            itemCount: reservasFiltradas.length,
            itemBuilder: (context, index) {
              final reserva = reservasFiltradas[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Bordes redondeados
                ),
                elevation: 5, // Sombra suave
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.zero, // Quita el padding por defecto
                    title: Text(
                      "${reserva['grupo_cita']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        _buildInfoRow("Hora Reserva:", reserva['hora_reserva']),
                        _buildInfoRow("Hora Cita:", reserva['hora_cita']),
                        _buildInfoRow(
                            "Centro Médico:", reserva['centro_medico']),
                        _buildInfoRow("Fecha Cita:", reserva['fecha_cita']),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Confirmar antes de eliminar
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Confirmar Eliminación"),
                              content: const Text(
                                  "¿Estás seguro de eliminar esta reserva?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Cerrar el diálogo
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _eliminarReserva(reserva['id_reserva']);
                                    Navigator.pop(context); // Cerrar el diálogo
                                  },
                                  child: const Text("Eliminar",
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Método auxiliar para construir una fila de información
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          Expanded(
            // Permite que el texto largo se ajuste
            child: Text(
              value,
              overflow: TextOverflow.ellipsis, // Corta el texto si es muy largo
              maxLines: 2, // Permite que se muestre en 2 líneas antes de cortar
            ),
          ),
        ],
      ),
    );
  }
}
