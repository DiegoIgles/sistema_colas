import 'package:flutter/material.dart';
import 'package:mi_primera_app/components/utils/sidebart.dart';
import 'package:mi_primera_app/models/laboratorio.dart';
import 'package:mi_primera_app/services/laboratorio/laboratorio_service.dart';

class LaboratorioScreen extends StatefulWidget {
  const LaboratorioScreen({super.key});

  @override
  _LaboratorioScreenState createState() => _LaboratorioScreenState();
}

class _LaboratorioScreenState extends State<LaboratorioScreen> {
  List<Laboratorio> laboratorios = []; // Lista de laboratorios original
  List<Laboratorio> filteredLaboratorios =
      []; // Lista filtrada para la búsqueda
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los datos al cargar la pantalla
    _loadLaboratorios();
  }

  // Cargar los laboratorios desde la API
  Future<void> _loadLaboratorios() async {
    try {
      final fetchedLaboratorios =
          await ServicioLaboratorio().obtenerServiciosLaboratorio();
      setState(() {
        laboratorios = fetchedLaboratorios;
        filteredLaboratorios = laboratorios;
      });
    } catch (e) {
      print("Error al cargar los laboratorios: $e");
    }
  }

  // Filtrar laboratorios según el texto ingresado
  void _filterLaboratorios(String query) {
    final filtered = laboratorios.where((laboratorio) {
      return laboratorio.nombre.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredLaboratorios = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
        title: const Text(
          'Laboratorios',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // Campo de búsqueda en el AppBar
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: LaboratorioSearchDelegate(filteredLaboratorios),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Laboratorio>>(
        future: ServicioLaboratorio().obtenerServiciosLaboratorio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Cuando los datos están cargados, usamos la lista filtrada
          final laboratorios = filteredLaboratorios;

          return ListView.builder(
            itemCount: laboratorios.length,
            itemBuilder: (context, index) {
              final laboratorio = laboratorios[index];
              return ListTile(
                title: Text('${laboratorio.nombre}'),
                subtitle: Text('ID: ${laboratorio.id}'),
              );
            },
          );
        },
      ),
    );
  }
}

class LaboratorioSearchDelegate extends SearchDelegate {
  final List<Laboratorio> laboratorios;

  LaboratorioSearchDelegate(this.laboratorios);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpiar la búsqueda
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Cerrar el buscador
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = laboratorios
        .where((laboratorio) =>
            laboratorio.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final laboratorio = results[index];
        return ListTile(
          title: Text('ID: ${laboratorio.id}'),
          subtitle: Text('${laboratorio.nombre}'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = laboratorios
        .where((laboratorio) =>
            laboratorio.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final laboratorio = suggestions[index];
        return ListTile(
          title: Text('${laboratorio.nombre}'),
          subtitle: Text('ID: ${laboratorio.id}'),
        );
      },
    );
  }
}
