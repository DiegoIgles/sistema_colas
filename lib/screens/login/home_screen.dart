import 'package:flutter/material.dart';
import 'package:mi_primera_app/components/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
        title: const Text(
          'Inicio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal, // Fondo con color suave
        elevation: 5, // Agregar sombra a la AppBar
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo ajustada
          Image.asset(
            'assets/utils/cps.png',
            fit: BoxFit
                .cover, // Ajustar la imagen para que cubra el fondo sin acercarse demasiado
            alignment: Alignment.center, // Centrar la imagen
          ),
          // Filtro oscuro sobre la imagen
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Contenido principal centrado
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centrado verticalmente
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título de bienvenida centrado
                Text(
                  'Bienvenido a la App',
                  textAlign: TextAlign.center, // Centrado del texto
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(3, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Espaciado entre los elementos

                // Descripción breve sobre la app
                Text(
                  'Gestiona tus citas y reservas con facilidad y rapidez.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
