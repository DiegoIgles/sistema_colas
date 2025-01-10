import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: 70,
        ), //margen superior del icono
        Center(
          child: SizedBox(
            width: 200,
            child: Image(
              image: AssetImage('assets/utils/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    ));
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: _bubble()),
          Positioned(top: -40, left: -30, child: _bubble()),
          Positioned(top: 150, left: 250, child: _bubble()),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 135, 201, 255),
        Color.fromARGB(0, 5, 8, 166),
      ]));
}

class _bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.5)),
    );
  }
}
