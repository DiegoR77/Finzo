import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/enums.dart';
import '../../utils/app_theme.dart';
import '../../utils/currency_formatter.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cuentas')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        children: [
          ...mockAccounts.map((account) {
            final balance = computeBalance(account.id);
            return _AccountCard(
              name: account.name,
              type: account.type,
              balance: balance,
            );
          }),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Agregar cuenta'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final String name;
  final AccountType type;
  final int balance;

  const _AccountCard({
    required this.name,
    required this.type,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (type) {
      AccountType.cash => (Icons.payments_outlined, const Color(0xFF1D9E75)),
      AccountType.bank => (Icons.account_balance_outlined, AppColors.primary),
      AccountType.card => (Icons.credit_card_outlined, const Color(0xFFD85A30)),
      AccountType.other => (Icons.wallet_outlined, Colors.grey),
    };
    final typeLabel = switch (type) {
      AccountType.cash => 'Efectivo',
      AccountType.bank => 'Banco',
      AccountType.card => 'Tarjeta',
      AccountType.other => 'Otro',
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(typeLabel, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            Text(
              formatCOP(balance),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: balance >= 0 ? AppColors.income : AppColors.expense,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
