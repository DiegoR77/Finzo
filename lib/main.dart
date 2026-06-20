import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FinzoApp(),
    ),
  );
}

class FinzoApp extends StatelessWidget {
  const FinzoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Finzo',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
