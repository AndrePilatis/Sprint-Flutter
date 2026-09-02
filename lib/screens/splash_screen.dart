import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
                child: Icon(
                  Icons.water_drop_rounded,
                  size: 48,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Lactare',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Painel do Gestor de BLH',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Conecta BLH · Challenge FIAP x Eurofarma\n\n'
                'Acompanhe a agenda de coletas, o estoque de leite humano '
                'e as nutrizes conectadas pela LARA em um só lugar.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar no painel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
