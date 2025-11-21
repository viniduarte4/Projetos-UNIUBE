import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _error = '';

  void _login() {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    if (email.isEmpty || pass.isEmpty) {
      setState(() => _error = 'Preencha email e senha');
      return;
    }
    final success = StorageService.login(email, pass);
    if (success) {
      Navigator.pushReplacementNamed(context, '/calendar');
    } else {
      setState(() => _error = 'Usuário não encontrado. Cadastre-se.');
    }
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
              Text('Bem-vindo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 8),
              TextField(controller: _passCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Senha')),
              SizedBox(height: 12),
              ElevatedButton(onPressed: _login, child: Text('Entrar')),
              TextButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: Text('Cadastre-se')),
              if (_error.isNotEmpty) ...[
                SizedBox(height: 10),
                Text(_error, style: TextStyle(color: Colors.red))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
