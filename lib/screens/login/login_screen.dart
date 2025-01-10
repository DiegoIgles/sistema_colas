import 'package:flutter/material.dart';
import 'package:mi_primera_app/components/utils/sidebart.dart';
import 'package:mi_primera_app/providers/providers.dart';
import 'package:mi_primera_app/screens/login/home_screen.dart';
import 'package:mi_primera_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBart(),
      appBar: AppBar(
        title: const Text(
          'Proyecto',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                  child: Column(
                children: [
                  Text(
                    'Iniciar sesion',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  )
                ],
              )),
              const SizedBox(height: 50),
              const Text('Bienvenido',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => loginForm.email = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value != null && value.length >= 8) return null;
              return 'la contraseña es demasiado corta';
            },
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              color: const Color.fromARGB(247, 81, 169, 242),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                print('presionado');
                // print(loginForm.email);
                // print(loginForm.password);
                bool validate = true;
                if (validate) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } else {
                  print('falso');
                }
              })
        ],
      ),
    );
  }
}
