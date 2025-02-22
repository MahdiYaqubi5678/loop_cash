import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bar_graph/bar_graph.dart';
import '../database/expense_database.dart';
import '../database/income_database.dart';

class ProfitUi extends StatefulWidget {
  const ProfitUi({super.key});

  @override
  State<ProfitUi> createState() => _ProfitUiState();
}

class _ProfitUiState extends State<ProfitUi> {
  double dailyProfit = 0;
  double monthlyProfit = 0;
  double yearlyProfit = 0;
  List<double> monthlySummary = List.filled(12, 0.0);

  @override
  void initState() {
    super.initState();
    calculateProfits();
  }

  void calculateProfits() {
    final incomeDb = Provider.of<IncomeDatabase>(context, listen: false);
    final expenseDb = Provider.of<ExpenseDatabase>(context, listen: false);

    DateTime today = DateTime.now();

    double todayIncome = incomeDb.allIncomes
        .where((income) => income.date.year == today.year &&
            income.date.month == today.month &&
            income.date.day == today.day)
        .fold(0, (sum, income) => sum + income.amount);

    double todayExpense = expenseDb.allExpenses
        .where((expense) => expense.date.year == today.year &&
            expense.date.month == today.month &&
            expense.date.day == today.day)
        .fold(0, (sum, expense) => sum + expense.amount);

    dailyProfit = todayIncome - todayExpense;

    for (int month = 0; month < 12; month++) {
      double currentMonthIncome = incomeDb.allIncomes
          .where((income) => income.date.year == today.year &&
              income.date.month == month + 1)
          .fold(0, (sum, income) => sum + income.amount);

      double currentMonthExpense = expenseDb.allExpenses
          .where((expense) => expense.date.year == today.year &&
              expense.date.month == month + 1)
          .fold(0, (sum, expense) => sum + expense.amount);

      monthlySummary[month] = currentMonthIncome - currentMonthExpense;
    }

    double currentYearIncome = incomeDb.allIncomes
        .where((income) => income.date.year == today.year)
        .fold(0, (sum, income) => sum + income.amount);

    double currentYearExpense = expenseDb.allExpenses
        .where((expense) => expense.date.year == today.year)
        .fold(0, (sum, expense) => sum + expense.amount);

    yearlyProfit = currentYearIncome - currentYearExpense;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Center(
          child: Text(
            "Profit",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 300),
            // Daily Made
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  _buildProfitCard("today_made", dailyProfit),
                  const Spacer(),
                  _buildProfitCard("month_made", monthlyProfit),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Yearly Made
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildProfitCard("year_made", yearlyProfit),
            ),
            // Bar Graph
            const SizedBox(height: 20),
             MyBarGraph(
              monthlySummary: monthlySummary,
              startMonth: DateTime.now().month - 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfitCard(String titleKey, double amount) {
    return Container(
      height: 125,
      width: 205,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            titleKey.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            amount.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
