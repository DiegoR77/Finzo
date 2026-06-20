import '../models/account.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../models/enums.dart';

final mockAccounts = [
  Account(
    id: 1,
    name: 'Efectivo',
    type: AccountType.cash,
    initialBalance: 200000,
    createdAt: DateTime(2026, 1, 1),
  ),
  Account(
    id: 2,
    name: 'Bancolombia',
    type: AccountType.bank,
    initialBalance: 1500000,
    createdAt: DateTime(2026, 1, 1),
  ),
  Account(
    id: 3,
    name: 'Tarjeta Visa',
    type: AccountType.card,
    initialBalance: 0,
    createdAt: DateTime(2026, 1, 1),
  ),
];

final mockCategories = [
  // Gastos
  Category(id: 1, name: 'Alimentación', iconName: 'restaurant', colorValue: 0xFFE57373, type: CategoryType.expense, isDefault: true),
  Category(id: 2, name: 'Transporte', iconName: 'directions_car', colorValue: 0xFF64B5F6, type: CategoryType.expense, isDefault: true),
  Category(id: 3, name: 'Entretenimiento', iconName: 'movie', colorValue: 0xFFBA68C8, type: CategoryType.expense, isDefault: true),
  Category(id: 4, name: 'Salud', iconName: 'health_and_safety', colorValue: 0xFF4DB6AC, type: CategoryType.expense, isDefault: true),
  Category(id: 5, name: 'Educación', iconName: 'school', colorValue: 0xFFFFB74D, type: CategoryType.expense, isDefault: true),
  Category(id: 6, name: 'Ropa', iconName: 'checkroom', colorValue: 0xFFF06292, type: CategoryType.expense, isDefault: true),
  Category(id: 7, name: 'Servicios', iconName: 'receipt_long', colorValue: 0xFF90A4AE, type: CategoryType.expense, isDefault: true),
  Category(id: 8, name: 'Hogar', iconName: 'home', colorValue: 0xFFA5D6A7, type: CategoryType.expense, isDefault: true),
  // Ingresos
  Category(id: 9, name: 'Salario', iconName: 'work', colorValue: 0xFF1D9E75, type: CategoryType.income, isDefault: true),
  Category(id: 10, name: 'Freelance', iconName: 'computer', colorValue: 0xFF534AB7, type: CategoryType.income, isDefault: true),
  Category(id: 11, name: 'Inversiones', iconName: 'trending_up', colorValue: 0xFF26C6DA, type: CategoryType.income, isDefault: true),
  Category(id: 12, name: 'Regalo', iconName: 'card_giftcard', colorValue: 0xFFEF5350, type: CategoryType.income, isDefault: true),
  // Ambos
  Category(id: 13, name: 'Otros', iconName: 'category', colorValue: 0xFF78909C, type: CategoryType.both, isDefault: true),
];

final _now = DateTime.now();

final mockTransactions = [
  Transaction(id: 1, amount: 2500000, date: DateTime(_now.year, _now.month, 1), type: TransactionType.income, categoryId: 9, accountId: 2, note: 'Salario junio', createdAt: DateTime(_now.year, _now.month, 1)),
  Transaction(id: 2, amount: 45000, date: DateTime(_now.year, _now.month, 2), type: TransactionType.expense, categoryId: 1, accountId: 1, note: 'Mercado semanal', createdAt: DateTime(_now.year, _now.month, 2)),
  Transaction(id: 3, amount: 28000, date: DateTime(_now.year, _now.month, 3), type: TransactionType.expense, categoryId: 2, accountId: 1, note: 'Bus + metro', createdAt: DateTime(_now.year, _now.month, 3)),
  Transaction(id: 4, amount: 350000, date: DateTime(_now.year, _now.month, 5), type: TransactionType.income, categoryId: 10, accountId: 2, note: 'Proyecto web', createdAt: DateTime(_now.year, _now.month, 5)),
  Transaction(id: 5, amount: 89000, date: DateTime(_now.year, _now.month, 7), type: TransactionType.expense, categoryId: 7, accountId: 2, note: 'Internet y luz', createdAt: DateTime(_now.year, _now.month, 7)),
  Transaction(id: 6, amount: 60000, date: DateTime(_now.year, _now.month, 10), type: TransactionType.expense, categoryId: 3, accountId: 3, note: 'Cine y cena', createdAt: DateTime(_now.year, _now.month, 10)),
  Transaction(id: 7, amount: 35000, date: DateTime(_now.year, _now.month, 12), type: TransactionType.expense, categoryId: 1, accountId: 1, note: 'Restaurante', createdAt: DateTime(_now.year, _now.month, 12)),
  Transaction(id: 8, amount: 120000, date: DateTime(_now.year, _now.month, 14), type: TransactionType.expense, categoryId: 6, accountId: 3, note: 'Ropa nueva', createdAt: DateTime(_now.year, _now.month, 14)),
  Transaction(id: 9, amount: 25000, date: DateTime(_now.year, _now.month, 15), type: TransactionType.expense, categoryId: 2, accountId: 1, note: 'Taxi', createdAt: DateTime(_now.year, _now.month, 15)),
  Transaction(id: 10, amount: 200000, date: DateTime(_now.year, _now.month, 18), type: TransactionType.expense, categoryId: 5, accountId: 2, note: 'Semestre universidad', createdAt: DateTime(_now.year, _now.month, 18)),
];

int computeBalance(int accountId) {
  final account = mockAccounts.firstWhere((a) => a.id == accountId);
  int balance = account.initialBalance;
  for (final t in mockTransactions) {
    if (t.accountId != accountId) continue;
    if (t.type == TransactionType.income) {
      balance += t.amount;
    } else {
      balance -= t.amount;
    }
  }
  return balance;
}

int get totalBalance => mockAccounts.fold(0, (sum, a) => sum + computeBalance(a.id));

int get monthlyIncome => mockTransactions
    .where((t) => t.type == TransactionType.income)
    .fold(0, (sum, t) => sum + t.amount);

int get monthlyExpense => mockTransactions
    .where((t) => t.type == TransactionType.expense)
    .fold(0, (sum, t) => sum + t.amount);
