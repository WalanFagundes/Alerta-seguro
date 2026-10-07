import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onLogout});

  final String _nomeCompleto = 'Maria Silva';
  final String _userEmail = 'maria.silva@email.com';
  final String _telefoneEmergencia = '+55 11 98765-4321';
  final String _idAnonimo = 'Usuário #4092';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person_outline, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            _idAnonimo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.security, size: 14, color: Colors.green),
                SizedBox(width: 4),
                Text(
                  'Modo Anônimo Ativo para Outros Usuários',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dados Privados (Apenas Uso Interno)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.badge, color: Colors.red),
                    title: const Text('Nome Registrado'),
                    subtitle: Text(_nomeCompleto),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.email, color: Colors.red),
                    title: const Text('E-mail do Cadastro'),
                    subtitle: Text(_userEmail),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.phone, color: Colors.red),
                    title: const Text('Telefone de Emergência'),
                    subtitle: Text(_telefoneEmergencia),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              onPressed: onLogout,
              child: const Text('SAIR / LOGOUT'),
            ),
          ),
        ],
      ),
    );
  }
}