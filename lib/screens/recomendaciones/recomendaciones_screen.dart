import 'package:flutter/material.dart';
import 'package:mi_primera_app/services/recomendacion/recomendacion_service.dart';
import 'package:mi_primera_app/screens/reserva/misreservas_screen.dart'; // Importar MisReservasScreen
import 'package:mi_primera_app/components/utils/sidebart.dart';

class RecomendacionesScreen extends StatefulWidget {
  final int solservicioId;
  final int afiliadoId;

  const RecomendacionesScreen({
    Key? key,
    required this.solservicioId,
    required this.afiliadoId,
  }) : super(key: key);

  @override
  _RecomendacionesScreenState createState() => _RecomendacionesScreenState();
}

class _RecomendacionesScreenState extends State<RecomendacionesScreen> {
  late Future<dynamic>
      _recomendaciones; // Usamos dynamic para manejar tanto Map como List

  @override
  void initState() {
    super.initState();
    _recomendaciones = RecomendacionService()
        .obtenerRecomendacionesPorSolservicio(widget.solservicioId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
          title: const Text(
        'Recomendaciones',
        style: TextStyle(color: Colors.white),
      )),
      body: FutureBuilder<dynamic>(
        // Usamos dynamic para manejar ambos casos
        future: _recomendaciones,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            final recomendaciones = snapshot.data;

            List<dynamic> recomendacionList = [];

            // Verificamos si la respuesta es un Map o una lista
            if (recomendaciones is Map<String, dynamic>) {
              // Si es un mapa, extraemos los valores (que son las recomendaciones)
              recomendacionList = recomendaciones.values.toList();
            } else if (recomendaciones is List<dynamic>) {
              // Si ya es una lista, la usamos directamente
              recomendacionList = recomendaciones;
            }

            if (recomendacionList.isEmpty) {
              return const Center(child: Text('No hay recomendaciones.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: recomendacionList.length,
                    itemBuilder: (context, index) {
                      final recomendacion = recomendacionList[index];
                      final laboratorioNombre =
                          recomendacion['laboratorio_nombre'] ??
                              'Laboratorio Desconocido';
                      final textoRecomendacion =
                          recomendacion['recomendacion'] ?? 'Sin recomendación';

                      return Card(
                        margin: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            laboratorioNombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(textoRecomendacion),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MisReservasScreen(
                            afiliadoId: widget.afiliadoId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 40.0),
                    ),
                    child: const Text(
                      "Ir a Mis Reservas",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
              child: Text('No se encontraron recomendaciones.'));
        },
      ),
    );
  }
}
