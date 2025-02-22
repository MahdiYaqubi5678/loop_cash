import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/income.dart';

class IncomeDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<Income> _allIncomes = [];

  // initialize app
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [IncomeSchema], 
      directory: dir.path,
    );
  }


  // getters
  List<Income> get allIncomes => _allIncomes;


  // create - create the eExpensxpenses
  Future<void> createNewIncome(Income newIncome) async {
    // add to db
    await isar.writeTxn(() => isar.incomes.put(newIncome));

    // reread the db
    await readIncomes();
  }

  // read - read the expense
  Future<void> readIncomes() async {
    // fetch all of the existing expenses from db
    List<Income> fetchIncomes = await isar.incomes.where().findAll();

    // give to local expense list
    _allIncomes.clear();
    _allIncomes.addAll(fetchIncomes);

    // update ui
    notifyListeners();
  }

  // update - update the expenses
  Future<void> updateIncomes(int id, Income updateIncomes) async {
    // make sure the new id has the same as existing
    updateIncomes.id = id;

    // update the db
    await isar.writeTxn(() => isar.incomes.put(updateIncomes));

    // reread the db
    await readIncomes();
  }

  // delete - delete it
  Future<void> deleteIncome(int id) async {
    // delete from db
    await isar.writeTxn(() => isar.incomes.delete(id));

    // reread the db
    await readIncomes();
  }


  // calculate total expenses for each month
  Future<Map<String, double>> calculateMontlyTotals() async {
    // ensure that the expenses are read from the db
    await readIncomes();

    // create a map to keep track of total monthly expneses
    Map<String, double> monthlyTotals = {
      // 0: 250 jan

      // 1: 100 feb 

    };

    // iterite all of the expenses
    for (var income in _allIncomes) {
      // extract the month from the data of the each expneses
      String yearMonth = 
          '${income.date.year}-${income.date.month}';

      // if the map is not yet in the map, initialize to 0
      if (!monthlyTotals.containsKey(yearMonth)) {
        monthlyTotals[yearMonth] = 0;
      }

      // add the expense amount to total for the month
      monthlyTotals[yearMonth] = monthlyTotals[yearMonth]! + income.amount;
    }
    return monthlyTotals;
  }

  // calculate current month total
  Future<double> calculateCurrentMonthTotal() async {
    // ensure the expenses are read from the db
    await readIncomes();

    // get current month, year
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;

    // filter the expenses to include only those for this month this year
    List<Income> currentMonthIncome = _allIncomes.where((incomes) {
      return incomes.date.month == currentMonth && incomes.date.year == currentYear;
    }).toList();

    // calculate total amount for the current month
    double total = 
        currentMonthIncome.fold(0, (sum, incomes) => sum + incomes.amount);

    return total;
  }

  // get start month 
  int getStartMonth() {
    if (_allIncomes.isEmpty) {
      return DateTime.now().month;
    }

    // sort the expenses by date to find the earlist
    _allIncomes.sort(
      (a, b) => a.date.compareTo(b.date),
    );

    return _allIncomes.first.date.month;
  }

  // get start year
  int getStartYear() {
    if (_allIncomes.isEmpty) {
      return DateTime.now().year;
    }

    // sort the expenses by date to find the earlist
    allIncomes.sort(
      (a, b) => a.date.compareTo(b.date),
    );

    return _allIncomes.first.date.year;
  }

}