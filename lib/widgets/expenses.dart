import 'package:expense_tracker_app/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter course',
      amount: 120,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'tavuk döner',
      amount: 130,
      date: DateTime.now(),
      category: Category.food,
    )
  ];

  @override
  Widget build(BuildContext context) {
    // wrap inner column with expanded widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker App'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Column(
        children: [
          const Text('the chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          )
        ],
      ),
    );
  }
}
