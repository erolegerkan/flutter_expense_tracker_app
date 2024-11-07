import 'package:expense_tracker_app/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  //when you are in a class that extends state flutter automatically adds a context property to your class.
  // this context value holds an information about this expenses widget an also hold the place of the class in the widget tree.
  final List<Expense> _registeredExpenses = [];

  void _addExpenses(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenses(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    //builder needs a function
    showModalBottomSheet(
      //to avoid device features like camera that might be affecting our ui - widgets like Scaffold widgets automatically use that feature
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenses),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
        child: Text(
      'No expenses found,\nstart adding some!',
      style: TextStyle(fontSize: 30),
    ));
    // wrap inner column with expanded widget
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Expense Tracker App'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? (_registeredExpenses.isNotEmpty)
                ? Column(children: [
                    Chart(expenses: _registeredExpenses),
                    Expanded(
                      child: ExpensesList(
                        expenses: _registeredExpenses,
                        deleteExpense: _removeExpenses,
                      ),
                    )
                  ])
                : mainContent
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                      child: ExpensesList(
                        expenses: _registeredExpenses,
                        deleteExpense: _removeExpenses,
                      ),
                    )
                ],
              ));
  }
}
