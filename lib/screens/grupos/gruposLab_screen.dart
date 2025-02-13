import 'package:flutter/material.dart';
import 'package:mi_primera_app/models/grupo.dart';
import 'package:mi_primera_app/screens/citaLab/disponibilidad_screen.dart';
import 'package:mi_primera_app/services/grupos/grupos_centro_medicos_service.dart';
import 'package:intl/intl.dart';

class GruposPorServicioScreen extends StatefulWidget {
  final int servicioId;
  final int userId;
  final int centroMedicoId;

  const GruposPorServicioScreen({
    super.key,
    required this.servicioId,
    required this.userId,
    required this.centroMedicoId,
  });

  @override
  _GruposPorServicioScreenState createState() =>
      _GruposPorServicioScreenState();
}

class _GruposPorServicioScreenState extends State<GruposPorServicioScreen> {
  late TextEditingController _fechaController;
  String _fechaSeleccionada = "";

  @override
  void initState() {
    super.initState();
    _fechaSeleccionada = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fechaController = TextEditingController(text: _fechaSeleccionada);
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        _fechaSeleccionada = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
        _fechaController.text = _fechaSeleccionada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos del Servicio',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => _seleccionarFecha(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _fechaController,
                  decoration: InputDecoration(
                    labelText: 'Seleccionar fecha',
                    labelStyle: TextStyle(color: Colors.teal),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(Icons.calendar_today, color: Colors.teal),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Grupo>>(
              future: GruposCentroMedicosService().obtenerGruposPorCentroMedico(
                  widget.centroMedicoId, widget.servicioId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final grupos = snapshot.data ?? [];

                if (grupos.isEmpty) {
                  return const Center(
                      child: Text('No hay grupos disponibles.'));
                }

                return ListView.builder(
                  itemCount: grupos.length,
                  itemBuilder: (context, index) {
                    final grupo = grupos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
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
                            for (var laboratorio in grupo.laboratorios)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  '- ${laboratorio.nombre}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.teal,
                                    overflow: TextOverflow
                                        .ellipsis, // Asegura que el texto largo se ajuste
                                  ),
                                  maxLines: 1, // Limita a una línea
                                  softWrap: false, // No permite saltos de línea
                                ),
                              ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.teal),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DisponibilidadScreen(
                                  centroMedicoId: widget.centroMedicoId,
                                  grupoId: grupo.id,
                                  fecha: _fechaSeleccionada,
                                  afiliadoId: widget.userId,
                                  servicioId: widget.servicioId,
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
          ),
        ],
      ),
    );
  }
}
