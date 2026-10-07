import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const AlertaSeguroApp());
}

class AlertaSeguroApp extends StatelessWidget {
  const AlertaSeguroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alerta Seguro',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121214), // Fundo Grafite Escuro
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 3; // Inicia na aba de Perfil/Login
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeWidget(),
      const Center(
        child: Text(
          'Módulo de Mapa e Rotas\n(Pessoa 2)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
      const Center(
        child: Text(
          'Módulo de Ocorrências e Alertas\n(Pessoa 3)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
      _isLoggedIn
          ? ProfileScreen(
              onLogout: () {
                setState(() {
                  _isLoggedIn = false;
                });
              },
            )
          : LoginScreen(
              onLoginSuccess: () {
                setState(() {
                  _isLoggedIn = true;
                });
              },
            ),
    ];

    return Scaffold(
      // Exibe a AppBar apenas quando NÃO estiver no Login
      appBar: (_currentIndex == 3 && !_isLoggedIn)
          ? null
          : AppBar(
              title: const Text(
                'ALERTA SEGURO',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              backgroundColor: const Color(0xFF18181B),
              centerTitle: true,
            ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF18181B),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Alerta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Alertas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}