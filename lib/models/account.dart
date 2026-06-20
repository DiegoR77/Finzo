import 'enums.dart';

class Account {
  final int id;
  final String name;
  final AccountType type;

  /// Saldo con el que se abre la cuenta (COP, sin decimales).
  final int initialBalance;

  final DateTime createdAt;

  const Account({
    required this.id,
    required this.name,
    required this.type,
    required this.initialBalance,
    required this.createdAt,
  });

  Account copyWith({
    int? id,
    String? name,
    AccountType? type,
    int? initialBalance,
    DateTime? createdAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      initialBalance: initialBalance ?? this.initialBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
