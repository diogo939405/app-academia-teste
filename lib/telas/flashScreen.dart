import 'package:flutter/material.dart';
import 'package:app_academia_teste/telas/loginScreeb.dart';

class Flashscreen extends StatefulWidget {
  const Flashscreen({super.key});

  @override
  State<Flashscreen> createState() => _FlashscreenState();
}

class _FlashscreenState extends State<Flashscreen> {
  @override
  void initState() {
    super.initState();
    // Adicione o código para executar a ação após o carregamento da tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          // Verifica se o widget ainda está na árvore de widgets
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreeb()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fitness App',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'this is the best app for your fitness',
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
