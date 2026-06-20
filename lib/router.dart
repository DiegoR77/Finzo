import 'package:go_router/go_router.dart';

import 'screens/home/home_screen.dart';
import 'screens/transactions/transactions_screen.dart';
import 'screens/transactions/add_transaction_screen.dart';
import 'screens/accounts/accounts_screen.dart';
import 'screens/reports/reports_screen.dart';
import 'widgets/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, _) => const HomeScreen()),
        GoRoute(path: '/transactions', builder: (context, _) => const TransactionsScreen()),
        GoRoute(path: '/accounts', builder: (context, _) => const AccountsScreen()),
        GoRoute(path: '/reports', builder: (context, _) => const ReportsScreen()),
      ],
    ),
    GoRoute(
      path: '/add-transaction',
      builder: (context, _) => const AddTransactionScreen(),
    ),
  ],
);
