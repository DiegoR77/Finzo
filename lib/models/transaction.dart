import 'enums.dart';

class Transaction {
  final int id;

  /// Monto en COP, siempre positivo. El tipo determina si suma o resta.
  final int amount;

  final DateTime date;
  final TransactionType type;
  final int categoryId;
  final int accountId;
  final String? note;
  final DateTime createdAt;

  const Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.categoryId,
    required this.accountId,
    this.note,
    required this.createdAt,
  });

  Transaction copyWith({
    int? id,
    int? amount,
    DateTime? date,
    TransactionType? type,
    int? categoryId,
    int? accountId,
    String? note,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
