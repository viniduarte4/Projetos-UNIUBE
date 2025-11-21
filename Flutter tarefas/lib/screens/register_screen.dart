import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _message = '';

  void _register() {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    if (email.isEmpty || pass.isEmpty) {
      setState(() => _message = 'Preencha email e senha');
      return;
    }
    StorageService.register(email, pass);
    setState(() => _message = 'Registrado com sucesso! Faça login.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Criar conta', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 8),
              TextField(controller: _passCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Senha')),
              SizedBox(height: 12),
              ElevatedButton(onPressed: _register, child: Text('Cadastrar')),
              SizedBox(height: 8),
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Voltar ao login')),
              if (_message.isNotEmpty) ...[
                SizedBox(height: 10),
                Text(_message, style: TextStyle(color: Colors.green))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
