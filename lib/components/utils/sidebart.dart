import 'package:flutter/material.dart';

class SideBart extends StatelessWidget {
  const SideBart({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Diego Iglesias'),
            accountEmail: const Text('Diego@gmail.com'),
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
            leading: const Icon(Icons.login),
            title: const Text('Iniciar Sesion'),
            onTap: () {
              print('presionado iniciar sesion');
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
              print('presionado cerrar sesion');
            },
          ),
        ],
      ),
    );
  }
}
