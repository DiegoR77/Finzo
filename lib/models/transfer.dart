class Transfer {
  final int id;
  final int fromAccountId;
  final int toAccountId;

  /// Monto en COP, siempre positivo.
  final int amount;

  final DateTime date;
  final String? note;
  final DateTime createdAt;

  const Transfer({
    required this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.date,
    this.note,
    required this.createdAt,
  });

  Transfer copyWith({
    int? id,
    int? fromAccountId,
    int? toAccountId,
    int? amount,
    DateTime? date,
    String? note,
    DateTime? createdAt,
  }) {
    return Transfer(
      id: id ?? this.id,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
