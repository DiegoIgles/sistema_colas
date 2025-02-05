import 'package:flutter/material.dart';
import 'package:mi_primera_app/screens/screens.dart';

class MenuScreen extends StatelessWidget {
  final int userId; // Se pasa el servicioId al construir esta pantalla.

  const MenuScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
        title: const Text(
          'Menú',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal, // AppBar con color llamativo
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade100, Colors.blue.shade100],
          ), // Fondo degradado para la pantalla
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Botón de Laboratorio con gradiente
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiciosScreen(userId: userId),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal
                        .shade400, // Usar backgroundColor en lugar de primary
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Bordes redondeados
                    ),
                    shadowColor: Colors.teal.shade700,
                    elevation: 8,
                  ),
                  child: const Text(
                    'Laboratorio',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Espacio entre los botones

                // Botón de Gabinete con sombra
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue.shade400, // Usar backgroundColor
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.blue.shade700,
                    elevation: 8,
                  ),
                  child: const Text(
                    'Gabinete',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón de Rayos X con otro color
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange.shade400, // Usar backgroundColor
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.orange.shade700,
                    elevation: 8,
                  ),
                  child: const Text(
                    'Rayos X',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
