import 'package:flutter/material.dart';
import 'package:mi_primera_app/services/reserva/reserva_service.dart'; // Importar tu servicio de reserva
import 'package:mi_primera_app/screens/recomendaciones/recomendaciones_screen.dart'; // Importar tu servicio de reserva

class ReservarCitacreen extends StatefulWidget {
  final int citaId;
  final int afiliadoId;
  final int servicioId; // El ID del usuario (afiliado)

  const ReservarCitacreen({
    Key? key,
    required this.citaId,
    required this.afiliadoId,
    required this.servicioId,
  }) : super(key: key);

  @override
  _ReservarCitacreenState createState() => _ReservarCitacreenState();
}

class _ReservarCitacreenState extends State<ReservarCitacreen> {
  final _telefonoController =
      TextEditingController(); // Controlador para el teléfono
  final _formKey = GlobalKey<FormState>(); // Para validar el formulario
  String? _recomendacion; // Variable para almacenar la recomendación

  // Método para realizar la reserva de la cita
  void _reservarCita() async {
    if (_formKey.currentState?.validate() ?? false) {
      final telefono = _telefonoController.text;

      // Llamamos al servicio para reservar la cita
      final reservaService = ReservaService();
      final result = await reservaService.reservarCita(
        widget.citaId,
        widget.afiliadoId,
        telefono,
      );

      // Comprobamos el resultado
      if (result.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error al reservar la cita: ${result['error']}')),
        );
      } else {
        // Si la cita fue reservada con éxito, mostramos la recomendación
        setState(() {
          _recomendacion =
              result['recomendacion']; // Almacenamos la recomendación
        });

        // Mostrar la recomendación en un AlertDialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    12), // Bordes redondeados en el diálogo
              ),
              title: const Text("Cita Reservada con Éxito",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content:
                  Text(_recomendacion ?? "No hay recomendación disponible."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cerrar el diálogo

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecomendacionesScreen(
                          solservicioId: widget.servicioId,
                          afiliadoId: widget.afiliadoId,
                        ),
                      ),
                    );
                  },
                  child: const Text("Cerrar",
                      style: TextStyle(color: Colors.teal)),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reservar Cita",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // Color del AppBar
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Asegura que el formulario sea desplazable
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campo de teléfono
                TextFormField(
                  controller: _telefonoController,
                  decoration: InputDecoration(
                    labelText: "Número de Teléfono",
                    prefixIcon: Icon(Icons.phone, color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su número de teléfono';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                // Botón de confirmar
                Center(
                  child: ElevatedButton(
                    onPressed: _reservarCita,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 40.0),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Confirmar Reserva",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
