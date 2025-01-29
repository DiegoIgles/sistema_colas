import 'package:flutter/material.dart';
import 'package:mi_primera_app/screens/screens.dart';

class MenuScreen extends StatelessWidget {
  final int userId; // Se pasa el servicioId al construir esta pantalla.

  const MenuScreen({super.key, required this.userId});

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
                        ServiciosScreen(userId: userId),
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
