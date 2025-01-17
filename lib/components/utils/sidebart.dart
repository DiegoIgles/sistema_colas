import 'package:flutter/material.dart';
import 'package:mi_primera_app/screens/laboratorios/laboratorio_screen.dart';
import 'package:mi_primera_app/screens/login/home_screen.dart';
import 'package:mi_primera_app/screens/login/login_screen.dart';
import 'package:mi_primera_app/screens/servicios/servicios_screen.dart';
import 'package:mi_primera_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class SideBart extends StatelessWidget {
  const SideBart({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AuthService>(builder: (context, auth, child) {
        if (!auth.authentificated) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Iniciar Sesion'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
              ),
            ],
          );
        } else {
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  auth.user.nombre +
                      ' ' +
                      auth.user.paterno +
                      ' ' +
                      auth.user.materno,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/3135/3135768.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/utils/sidebar_fondo.jpg'),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                leading: const Icon(Icons.add_alarm),
                title: const Text('Mis servicios'),
                onTap: () {
                  // Verifica si el usuario está autenticado antes de pasar el userId
                  if (auth.authentificated) {
                    int userId =
                        auth.user.id; // Aquí obtenemos el ID del usuario
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiciosScreen(userId: userId),
                      ),
                    );
                  } else {
                    // Si el usuario no está autenticado, puedes mostrar un mensaje o redirigir a login
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Por favor inicia sesión primero')),
                    );
                    // Aquí podrías navegar a la pantalla de inicio de sesión si es necesario
                  }
                },
              ),
              const Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              ListTile(
                leading: const Icon(Icons.coronavirus_sharp),
                title: const Text('Laboratorios'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LaboratorioScreen(),
                    ),
                  );
                },
              ),
              const Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('cerrar Sesion'),
                onTap: () {
                  Provider.of<AuthService>(context, listen: false).logout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                },
              ),
            ],
          );
        }
      }),
    );
  }
}
