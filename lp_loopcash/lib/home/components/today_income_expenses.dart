import 'package:flutter/material.dart';

class TodayIncomeExpenses extends StatelessWidget {
  final String incomeExpensesAmount;
  final String incomeExpensesName;
  final IconData icon;

  const TodayIncomeExpenses({
    super.key,
    required this.incomeExpensesAmount,
    required this.incomeExpensesName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // paddings
      padding: const EdgeInsets.symmetric(horizontal: 10.0),

      // container
      child: Container(
        height: 100,
        width: 210,
        padding: const EdgeInsets.all(20),
        // decoration
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        // Icon & text
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Icon(icon),
            ),
            
            const SizedBox(width: 8,),
                                    
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$incomeExpensesAmount",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  incomeExpensesName,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}