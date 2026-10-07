import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool _alertaAtivo = false;

  void _dispararAlerta() {
    setState(() {
      _alertaAtivo = !_alertaAtivo;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _alertaAtivo ? 'ALERTA DE EMERGÊNCIA ENVIADO!' : 'Alerta cancelado.',
        ),
        backgroundColor: _alertaAtivo ? Colors.red[900] : Colors.grey,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _alertaAtivo ? 'EMERGÊNCIA ATIVA' : 'SISTEMA PRONTO',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _alertaAtivo ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _dispararAlerta,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: _alertaAtivo ? Colors.red[900] : Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (_alertaAtivo ? Colors.red : Colors.black).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _alertaAtivo ? Icons.warning : Icons.touch_app,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _alertaAtivo ? 'CANCELAR' : 'SOCORRO',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}