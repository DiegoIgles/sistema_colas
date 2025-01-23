import 'package:flutter/material.dart';
import 'package:mi_primera_app/screens/serviciosLab/serviciosLab_screen.dart';

class MenuScreen extends StatelessWidget {
  final int servicioId; // Se pasa el servicioId al construir esta pantalla.

  const MenuScreen({super.key, required this.servicioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ServiciosLabScreen(servicioId: servicioId),
                  ),
                );
              },
              child: const Text('Laboratorio'),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Gabinete'),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Rayos X'),
            ),
          ],
        ),
      ),
    );
  }
}
