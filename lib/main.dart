import 'package:flutter/material.dart';
import 'package:mi_primera_app/screens/screens.dart';
import 'package:mi_primera_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'proyecto1',
      initialRoute: 'splash',
      routes: {
        '/': (_) => const HomeScreen(),
        'splash': (_) => const SplashScreen(),
        'login': (_) => const LoginScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
              elevation: 0, color: Color.fromARGB(175, 10, 88, 76))),
    );
  }
}
