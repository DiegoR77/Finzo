import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../models/enums.dart';
import '../../utils/app_theme.dart';
import '../../utils/currency_formatter.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TransactionType _type = TransactionType.expense;
  int? _selectedCategoryId;
  int _selectedAccountId = mockAccounts.first.id;
  DateTime _date = DateTime.now();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  List<_CategoryOption> get _filteredCategories {
    return mockCategories
        .where((c) =>
            c.type == CategoryType.both ||
            (c.type == CategoryType.income && _type == TransactionType.income) ||
            (c.type == CategoryType.expense && _type == TransactionType.expense))
        .map((c) => _CategoryOption(category: c))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = _type == TransactionType.expense;
    final accentColor = isExpense ? AppColors.expense : AppColors.income;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo movimiento'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: const Text('Guardar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tipo: Ingreso / Gasto
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: TransactionType.values.map((t) {
                final selected = _type == t;
                final label = t == TransactionType.income ? 'Ingreso' : 'Gasto';
                final color = t == TransactionType.income ? AppColors.income : AppColors.expense;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _type = t;
                      _selectedCategoryId = null;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? color : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Monto
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: accentColor),
            decoration: InputDecoration(
              labelText: 'Monto (COP)',
              prefixText: '\$ ',
              prefixStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: accentColor),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          const SizedBox(height: 20),

          // Categoría
          const Text('Categoría', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _filteredCategories.map((opt) {
              final selected = _selectedCategoryId == opt.category.id;
              final color = Color(opt.category.colorValue);
              return GestureDetector(
                onTap: () => setState(() => _selectedCategoryId = opt.category.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? color : color.withAlpha(25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? color : Colors.transparent),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_iconData(opt.category.iconName), size: 16, color: selected ? Colors.white : color),
                      const SizedBox(width: 6),
                      Text(
                        opt.category.name,
                        style: TextStyle(
                          color: selected ? Colors.white : color,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Cuenta
          DropdownButtonFormField<int>(
            initialValue: _selectedAccountId,
            decoration: const InputDecoration(labelText: 'Cuenta'),
            items: mockAccounts.map((a) {
              return DropdownMenuItem(value: a.id, child: Text(a.name));
            }).toList(),
            onChanged: (v) => setState(() => _selectedAccountId = v!),
          ),

          const SizedBox(height: 16),

          // Fecha
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Fecha',
                suffixIcon: Icon(Icons.calendar_today_outlined),
              ),
              child: Text(formatDate(_date)),
            ),
          ),

          const SizedBox(height: 16),

          // Nota
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              labelText: 'Nota (opcional)',
              hintText: 'Ej: Mercado semanal',
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _onSave() {
    // Fase 3: validación visual únicamente — la persistencia llega en Fase 5.
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un monto')),
      );
      return;
    }
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una categoría')),
      );
      return;
    }
    context.pop();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
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

class _CategoryOption {
  final dynamic category;
  const _CategoryOption({required this.category});
}
