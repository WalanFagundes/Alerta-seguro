import 'dart:ui';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginScreen({super.key, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoginView = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleView() {
    setState(() {
      _isLoginView = !_isLoginView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      body: Stack(
        children: [
          // 1. Fundo de Cidade
          Positioned.fill(
            child: CustomPaint(
              painter: CityMapBackgroundPainter(),
            ),
          ),

          // 2. Camada Escura de Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.45),
            ),
          ),

          // 3. Conteúdo Principal
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Logo Escudo Neon
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.redAccent, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withValues(alpha: 0.4),
                            blurRadius: 30,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.shield, size: 60, color: Colors.white),
                    ),
                    const SizedBox(height: 14),

                    // Título em Destaque
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.5,
                        ),
                        children: [
                          TextSpan(text: 'ALERTA ', style: TextStyle(color: Colors.white)),
                          TextSpan(
                            text: 'SEGURO',
                            style: TextStyle(
                              color: Colors.redAccent,
                              shadows: [
                                Shadow(color: Colors.red, blurRadius: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'MONITORAMENTO URBANO EM TEMPO REAL',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- CONSTRAINEDBOX ADICIONADO AQUI ---
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420), // Trava a largura máxima de celular
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF141418).withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24, width: 1.2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black87,
                                  blurRadius: 25,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _isLoginView ? 'Acesse sua Conta' : 'Criar Nova Conta',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 18),

                                // Nome Completo (Apenas Cadastro)
                                if (!_isLoginView) ...[
                                  _buildTextField(
                                    controller: _nameController,
                                    label: 'Nome Completo',
                                    icon: Icons.person,
                                  ),
                                  const SizedBox(height: 14),
                                ],

                                // E-mail / CPF
                                _buildTextField(
                                  controller: _emailController,
                                  label: _isLoginView ? 'E-mail ou CPF' : 'E-mail',
                                  icon: Icons.email,
                                ),
                                const SizedBox(height: 14),

                                // Telefone (Apenas Cadastro)
                                if (!_isLoginView) ...[
                                  _buildTextField(
                                    controller: _phoneController,
                                    label: 'Telefone de Emergência',
                                    icon: Icons.phone,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  const SizedBox(height: 14),
                                ],

                                // Senha
                                _buildTextField(
                                  controller: _passwordController,
                                  label: 'Senha',
                                  icon: Icons.lock,
                                  obscureText: true,
                                ),

                                // Confirmar Senha (Apenas Cadastro)
                                if (!_isLoginView) ...[
                                  const SizedBox(height: 14),
                                  _buildTextField(
                                    controller: _confirmPasswordController,
                                    label: 'Confirmar Senha',
                                    icon: Icons.lock_outline,
                                    obscureText: true,
                                  ),
                                ],

                                // Esqueceu a Senha
                                if (_isLoginView) ...[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Instruções enviadas para o e-mail informado.'),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Esqueceu a senha?',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ] else
                                  const SizedBox(height: 16),

                                // Botão Ação Principal
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: widget.onLoginSuccess,
                                    child: Text(
                                      _isLoginView ? 'ENTRAR' : 'CADASTRAR E ENTRAR',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),
                                const Divider(color: Colors.white24),
                                const SizedBox(height: 8),

                                // Alternar Modo
                                SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.white54, width: 1.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: _toggleView,
                                    child: Text(
                                      _isLoginView ? 'Criar nova conta' : 'Já tenho uma conta',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.redAccent),
        filled: true,
        fillColor: const Color(0xFF1E1E24),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
    );
  }
}

// Pintor Vetorial para o Mapa Urbano
class CityMapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFF1F222E)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final mainRoadPaint = Paint()
      ..color = const Color(0xFF2C3142)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    final alertPaint = Paint()
      ..color = Colors.redAccent.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final alertCorePaint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill;

    for (double i = -size.width; i < size.width * 2; i += 70) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height * 0.5, size.height), roadPaint);
      canvas.drawLine(Offset(i + 200, 0), Offset(i - size.height * 0.3, size.height), roadPaint);
    }

    canvas.drawLine(Offset(0, size.height * 0.25), Offset(size.width, size.height * 0.35), mainRoadPaint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.6), mainRoadPaint);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.4, size.height), mainRoadPaint);

    final alertPoints = [
      Offset(size.width * 0.18, size.height * 0.2),
      Offset(size.width * 0.82, size.height * 0.28),
      Offset(size.width * 0.25, size.height * 0.75),
      Offset(size.width * 0.75, size.height * 0.82),
      Offset(size.width * 0.5, size.height * 0.15),
    ];

    for (var point in alertPoints) {
      canvas.drawCircle(point, 24, alertPaint);
      canvas.drawCircle(point, 12, alertPaint..color = Colors.redAccent.withValues(alpha: 0.6));
      canvas.drawCircle(point, 5, alertCorePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}