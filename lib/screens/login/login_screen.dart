import 'package:flutter/material.dart';
import 'package:mi_primera_app/components/utils/sidebart.dart';
import 'package:mi_primera_app/providers/providers.dart';
import 'package:mi_primera_app/services/services.dart';
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
            onChanged: (value) => loginForm.matricula = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            onChanged: (value) => loginForm.matricula = value,
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
              color: const Color.fromARGB(247, 10, 88, 76),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      // await Future.delayed(const Duration(seconds: 2));

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      String respuesta = await authService.login(
                          loginForm.matricula, 'movile');

                      if (respuesta == 'correcto') {
                        loginForm.isLoading = false;
                        Navigator.pop(context);
                      }
                    })
        ],
      ),
    );
  }
}
