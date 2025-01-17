import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Importamos la librería

class SolicitarFichaLaboratorioScreen extends StatefulWidget {
  const SolicitarFichaLaboratorioScreen({super.key});

  @override
  _SolicitarFichaLaboratorioScreenState createState() =>
      _SolicitarFichaLaboratorioScreenState();
}

class _SolicitarFichaLaboratorioScreenState
    extends State<SolicitarFichaLaboratorioScreen> {
  DateTime selectedDate = DateTime.now(); // Fecha seleccionada inicial
  String selectedLaboratorio =
      "Laboratorio A"; // Valor inicial para el laboratorio seleccionado
  final List<String> laboratorios = [
    "Laboratorio A",
    "Laboratorio B",
    "Laboratorio C"
  ]; // Lista de laboratorios disponibles

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar Ficha de Laboratorio'),
      ),
      body: SingleChildScrollView(
        // Envuelve todo el contenido con un SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selección del laboratorio
              const Text(
                'Selecciona un laboratorio:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedLaboratorio,
                items: laboratorios
                    .map((laboratorio) => DropdownMenuItem<String>(
                          value: laboratorio,
                          child: Text(laboratorio),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedLaboratorio =
                        newValue!; // Actualiza el laboratorio seleccionado
                  });
                },
              ),
              const SizedBox(height: 20),

              // Título para el calendario
              const Text(
                'Selecciona la fecha:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Usamos el calendario interactivo de 'table_calendar'
              TableCalendar(
                focusedDay: selectedDate, // Día inicial mostrado
                firstDay: DateTime.utc(2020, 1, 1), // Primera fecha disponible
                lastDay: DateTime.utc(2025, 12, 31), // Última fecha disponible
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate =
                        selectedDay; // Actualizamos la fecha seleccionada
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue, // Color de la fecha de hoy
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green, // Color de la fecha seleccionada
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible:
                      false, // Ocultar el botón de formato de mes
                  titleCentered: true, // Centrar el título
                ),
              ),
              const SizedBox(height: 20),

              // Botón para confirmar la solicitud (deshabilitado si no se ha seleccionado una fecha)
              ElevatedButton(
                onPressed: selectedDate != null
                    ? () {
                        // Aquí puedes manejar la lógica de la solicitud
                        print(
                            'Solicitando ficha para $selectedLaboratorio en ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}');
                      }
                    : null, // Deshabilitar el botón si no se ha seleccionado una fecha
                child: const Text('Confirmar Solicitud'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
