import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bar_graph/bar_graph.dart';
import '../database/expense_database.dart';
import '../database/income_database.dart';
import '../home/components/today_income_expenses.dart';
import '../model/expense.dart';
import '../model/income.dart';

class StaticsUi extends StatefulWidget {
  const StaticsUi({super.key});

  @override
  State<StaticsUi> createState() => _StaticsUiState();
}

class _StaticsUiState extends State<StaticsUi> {
  bool isEarningsSelected = true;
  Future<Map<String, double>>? _monthlyTotalsFuture;
  Future<double>? _calculateCurrentMonthTotal;
  Future<Map<String, double>>? _monthlyTotalsFutures;
  Future<double>? _calculateCurrentMonthTotals;
  
  final int monthCount = 12;
  final int startMonth = 1;
  final int startYear = 2025; 

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ExpenseDatabase>(context, listen: false).readExpenses();
      Provider.of<IncomeDatabase>(context, listen: false).readIncomes();
      refreshData();
    });
  }

  void refreshData() {
    setState(() {
      _monthlyTotalsFuture = Provider.of<ExpenseDatabase>(context, listen: false).calculateMontlyTotals();
      _calculateCurrentMonthTotal = Provider.of<ExpenseDatabase>(context, listen: false).calculateCurrentMonthTotal();
      _monthlyTotalsFutures = Provider.of<IncomeDatabase>(context, listen: false).calculateMontlyTotals();
      _calculateCurrentMonthTotals = Provider.of<IncomeDatabase>(context, listen: false).calculateCurrentMonthTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(
      builder: (context, expenseValue, child) {
        return Consumer<IncomeDatabase>(
          builder: (context, incomeValue, child) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 350,
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                title: Column(
                  children: [
                    Text(
                      "statics".tr(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder<double>(
                          future: _calculateCurrentMonthTotal,
                          builder: (context, snapshot) {
                            String amount = snapshot.connectionState == ConnectionState.done
                                ? snapshot.data?.toString() ?? "0.0"
                                : "Loading...";
                            return TodayIncomeExpenses(
                              incomeExpensesAmount: amount,
                              incomeExpensesName: "total_income".tr(),
                              icon: Icons.arrow_upward,
                            );
                          },
                        ),
                        FutureBuilder<double>(
                          future: _calculateCurrentMonthTotals,
                          builder: (context, snapshot) {
                            String amount = snapshot.connectionState == ConnectionState.done
                                ? snapshot.data?.toString() ?? "0.0"
                                : "Loading...";
                            return TodayIncomeExpenses(
                              incomeExpensesAmount: amount,
                              incomeExpensesName: "total_expenses".tr(),
                              icon: Icons.arrow_downward,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTab("earnings".tr(), isEarningsSelected, () {
                        setState(() {
                          isEarningsSelected = true;
                        });
                      }),
                      const SizedBox(width: 10),
                      _buildTab("spendings".tr(), !isEarningsSelected, () {
                        setState(() {
                          isEarningsSelected = false;
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: isEarningsSelected
                        ? _buildIncomeContent(incomeValue.allIncomes)
                        : _buildExpenseContent(expenseValue.allExpenses),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTab(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              isSelected ? Icons.arrow_drop_down : Icons.arrow_drop_up,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeContent(List<Income> incomes) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<Map<String, double>>(
        future: _monthlyTotalsFutures,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, double> monthlyTotals = snapshot.data ?? {};
            List<double> monthlySummary = _generateMonthlySummary(monthlyTotals);
            return MyBarGraph(monthlySummary: monthlySummary, startMonth: startMonth);
          } else {
            return const Center(child: Text("Loading..."));
          }
        },
      ),
    );
  }

  Widget _buildExpenseContent(List<Expense> expenses) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<Map<String, double>>(
        future: _monthlyTotalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, double> monthlyTotals = snapshot.data ?? {};
            List<double> monthlySummary = _generateMonthlySummary(monthlyTotals);
            return MyBarGraph(monthlySummary: monthlySummary, startMonth: startMonth);
          } else {
            return const Center(child: Text("Loading..."));
          }
        },
      ),
    );
  }

  List<double> _generateMonthlySummary(Map<String, double> monthlyTotals) {
    return List.generate(
      monthCount,
      (index) {
        int year = startYear + (startMonth + index - 1) ~/ 12;
        int month = (startMonth + index - 1) % 12 + 1;
        String yearMonthKey = '$year-$month';
        return monthlyTotals[yearMonthKey] ?? 0.0;
      },
    );
  }
}
