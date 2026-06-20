import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/transaction.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/transaction_list_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sorted = (mockTransactions.toList()
          ..sort((a, b) => b.date.compareTo(a.date)));
    final grouped = _groupByDate(sorted);

    return Scaffold(
      appBar: AppBar(title: const Text('Movimientos')),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: grouped.length,
        itemBuilder: (context, index) {
          final entry = grouped[index];
          return _DateGroup(date: entry.date, transactions: entry.transactions);
        },
      ),
    );
  }

  List<_TransactionGroup> _groupByDate(List<Transaction> transactions) {
    final map = <String, _TransactionGroup>{};
    for (final t in transactions) {
      final key = '${t.date.year}-${t.date.month}-${t.date.day}';
      map.putIfAbsent(key, () => _TransactionGroup(date: t.date, transactions: []));
      map[key]!.transactions.add(t);
    }
    return map.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }
}

class _TransactionGroup {
  final DateTime date;
  final List<Transaction> transactions;
  _TransactionGroup({required this.date, required this.transactions});
}

class _DateGroup extends StatelessWidget {
  final DateTime date;
  final List<Transaction> transactions;

  const _DateGroup({required this.date, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final dayTotal = transactions.fold<int>(0, (sum, t) {
      if (t.type.name == 'income') return sum + t.amount;
      return sum - t.amount;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDate(date),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                formatCOP(dayTotal),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: dayTotal >= 0 ? const Color(0xFF1D9E75) : const Color(0xFFD85A30),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        ...transactions.map((t) {
          final category = mockCategories.firstWhere((c) => c.id == t.categoryId);
          final account = mockAccounts.firstWhere((a) => a.id == t.accountId);
          return TransactionListItem(
            transaction: t,
            category: category,
            accountName: account.name,
          );
        }),
      ],
    );
  }
}
