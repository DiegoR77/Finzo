import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_theme.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/transactions')) return 1;
    if (location.startsWith('/accounts')) return 2;
    if (location.startsWith('/reports')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _selectedIndex(context);

    return Scaffold(
      extendBody: true,
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-transaction'),
        tooltip: 'Agregar movimiento',
        elevation: 4,
        child: const Icon(Icons.add, size: 28),
      ),
      bottomNavigationBar: _FloatingNavBar(
        currentIndex: index,
        onTap: (i) {
          switch (i) {
            case 0: context.go('/home');
            case 1: context.go('/transactions');
            case 2: context.go('/accounts');
            case 3: context.go('/reports');
          }
        },
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingNavBar({required this.currentIndex, required this.onTap});

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Inicio'),
    (icon: Icons.swap_horiz_outlined, activeIcon: Icons.swap_horiz_rounded, label: 'Movimientos'),
    (icon: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet_rounded, label: 'Cuentas'),
    (icon: Icons.bar_chart_outlined, activeIcon: Icons.bar_chart_rounded, label: 'Reportes'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = currentIndex == i;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary.withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            selected ? item.activeIcon : item.icon,
                            color: selected ? AppColors.primary : Colors.grey[400],
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                            color: selected ? AppColors.primary : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
