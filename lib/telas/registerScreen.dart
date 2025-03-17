import 'package:flutter/material.dart';
import 'package:app_academia_teste/widgtes/loading.dart';
import 'package:app_academia_teste/services/firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Novo Usuário'),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _senhaController,
                label: 'Senha',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _registerUser,
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[300],
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Preencha o campo $label';
        }
        return null;
      },
    );
  }

  void _registerUser() async {
    loading(context, true);
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _senhaController.text.trim();

      try {
        // Criando usuário no Firebase Authentication
        var user = await _firestoreService.createUserWithEmailAndPassword(
          email,
          password,
        );

        if (user != null) {
          // Agora salva o usuário no Firestore
          await _firestoreService.addUser(
            _emailController.text.trim(),
            _senhaController.text.trim(),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Usuário cadastrado com sucesso!")),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao cadastrar usuário")),
        );
      } finally {
        loading(context, false);
      }
    }
  }
}
