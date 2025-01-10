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
          'Home_Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Text('data'),
    );
  }
}
