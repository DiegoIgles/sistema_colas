import 'package:flutter/material.dart';
import 'package:mi_primera_app/components/utils/sidebart.dart';

class ServiciosScreen extends StatelessWidget {
  const ServiciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
        title: const Text(
          'mis servicios',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
