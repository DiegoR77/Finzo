import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 80, color: AppColors.primary.withAlpha(100)),
            const SizedBox(height: 16),
            const Text(
              'Gráficas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Disponible en Fase 6',
              style: TextStyle(color: Colors.grey[500], fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
