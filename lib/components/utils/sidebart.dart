import 'package:flutter/material.dart';
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
              const Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              ListTile(
                leading: const Icon(Icons.add_alarm),
                title: const Text('Mis servicios'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServiciosScreen(),
                      ));
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
