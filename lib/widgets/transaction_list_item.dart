import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../models/category.dart';
import '../models/enums.dart';
import '../utils/currency_formatter.dart';
import '../utils/app_theme.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final Category category;
  final String accountName;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.category,
    required this.accountName,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final amountColor = isIncome ? AppColors.income : AppColors.expense;
    final amountPrefix = isIncome ? '+' : '-';
    final iconColor = Color(category.colorValue);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: iconColor.withAlpha(30),
        child: Icon(_iconData(category.iconName), color: iconColor, size: 20),
      ),
      title: Text(
        category.name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        '$accountName${transaction.note != null ? ' · ${transaction.note}' : ''}',
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        '$amountPrefix${formatCOP(transaction.amount)}',
        style: TextStyle(
          color: amountColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  IconData _iconData(String name) {
    const map = {
      'restaurant': Icons.restaurant,
      'directions_car': Icons.directions_car,
      'movie': Icons.movie,
      'health_and_safety': Icons.health_and_safety,
      'school': Icons.school,
      'checkroom': Icons.checkroom,
      'receipt_long': Icons.receipt_long,
      'home': Icons.home,
      'work': Icons.work,
      'computer': Icons.computer,
      'trending_up': Icons.trending_up,
      'card_giftcard': Icons.card_giftcard,
      'category': Icons.category,
    };
    return map[name] ?? Icons.circle;
  }
}
