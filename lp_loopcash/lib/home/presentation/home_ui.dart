import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../database/expense_database.dart';
import '../../database/income_database.dart';
import '../../helper/helper_functions.dart';
import '../../model/expense.dart';
import '../../model/income.dart';
import '../../settings/settings_ui.dart';
import '../components/add_icome_expenses.dart';
import '../components/my_list_tile.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  // controllers
  TextEditingController exenseNameController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController incomeNameController = TextEditingController();
  TextEditingController incomeAmountController = TextEditingController();

  // futures
  Future<Map<String, double>>? _monthlyTotalsFuture;
  Future<double>? _calculateCurrentMonthTotal;

  // read 
  @override
  void initState() {

    // read the database initial startup
    Provider.of<ExpenseDatabase>(context, listen: false).readExpenses();
    Provider.of<IncomeDatabase>(context, listen: false).readIncomes();

    // load futures
    refreshData();

    super.initState();
  }

  // refresh the graph bar
  void refreshData() {
    _monthlyTotalsFuture = Provider.of<ExpenseDatabase>(context, listen: false).calculateMontlyTotals();
    _calculateCurrentMonthTotal = Provider.of<ExpenseDatabase>(context, listen: false).calculateCurrentMonthTotal();
  }

  // open new box for EXPENSES
  void openNewExpenseBox() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("New expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: exenseNameController,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            // expense amount
            TextField(
              controller: expenseAmountController,
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
            )
          ],
        ),
        actions: [
          // cancel
          _cancelButton(),

          // save
          _createNewExpenseButton(),
        ],
      ),
    );
  }

  // open edit box for EXPENSES
  void openEditExpense(Expense expense) {

    // prefill the existing info
    String existingName = expense.name;
    String existingAmount = expense.amount.toString();

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Edit expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: exenseNameController,
              decoration: InputDecoration(
                hintText: existingName,
              ),
            ),
            // expense amount
            TextField(
              controller: exenseNameController,
              decoration: InputDecoration(
                hintText: existingAmount,
              ),
            )
          ],
        ),
        actions: [
          // cancel
          _cancelButton(),

          // save
          _editExpenseButton(expense),
        ],
      ),
    );
  }

  // open delete box for EXPENSES
  void openDeleteExpense(Expense expense) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Edit expense"),
        actions: [
          // cancel
          _cancelButton(),

          // delete
          _deleteExpenseButton(expense.id),
        ],
      ),
    );
  }

  void openNewIncomeBox() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("New income"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: incomeNameController,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            // expense amount
            TextField(
              controller: incomeNameController,
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
            )
          ],
        ),
        actions: [
          // cancel
          _cancelButtonIncome(),

          // save
          _createNewIncomeButton(),
        ],
      ),
    );
  }

  // open edit box
  void openEditIncome(Income income) {

    // prefill the existing info
    String existingName = income.name;
    String existingAmount = income.amount.toString();

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Edit income"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: incomeNameController,
              decoration: InputDecoration(
                hintText: existingName,
              ),
            ),
            // expense amount
            TextField(
              controller: incomeAmountController,
              decoration: InputDecoration(
                hintText: existingAmount,
              ),
            )
          ],
        ),
        actions: [
          // cancel
          _cancelButtonIncome(),

          // save
          _editIncomeButton(income),
        ],
      ),
    );
  }

  // open delete box
  void openDeleteIncome(Income income) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Delete income"),
        actions: [
          // cancel
          _cancelButtonIncome(),

          // delete
          _deleteIncomeButton(income.id),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(
      builder: (context, value, child) {
        // get dates
        //int startMonth = value.getStartMonth();
        //int startYear = value.getStartYear();
        int currentMonth = DateTime.now().month;
        int currentYear = DateTime.now().year;

        // calculate the number of months since the first month
        //int monthCount = calculateMonthCount(startYear, startMonth, currentYear, currentMonth);

        // display all of the expesnes for the current month
        List<Expense> currentMonthExpense =
            value.allExpenses.where((expense) {
              return expense.date.year == currentYear &&
                  expense.date.month == currentMonth;
            }).toList();

        return Consumer<IncomeDatabase>(
          builder: (context, value, child) {
            // get dates
            //int startMonth = value.getStartMonth();
            //int startYear = value.getStartYear();
            int currentMonth = DateTime.now().month;
            int currentYear = DateTime.now().year;

            // calculate the number of months since the first month
            //int monthCount = calculateMonthCount(startYear, startMonth, currentYear, currentMonth);

            // display all of the expesnes for the current month
            List<Income> currentMonthIncome =
                value.allIncomes.where((income) {
                  return income.date.year == currentYear &&
                      income.date.month == currentMonth;
                }).toList();

            return Scaffold(

              // bg
              backgroundColor: Theme.of(context).colorScheme.surface,

              // appbar
              appBar: AppBar(
                automaticallyImplyLeading: false,
                // title
                title: Text(
                  "LoopCash",
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                // the person
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20 ,right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const SettingsUi(showBack: true,),
                            ),
                          );
                        }, 
                        icon: Icon(
                          Icons.person,
                          size: 20,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                  
                    // hi message
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "hi".tr(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "welcome".tr(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                    // sized box
                    const SizedBox(height: 30,),
                  
                    // icome and expenses
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // income
                        AddIcomeExpenses(
                          text: "add_income".tr(), 
                          icon: Icons.add,
                          onTap: openNewIncomeBox,
                          ),
                
                        // spacer
                        const Spacer(),
                  
                        // expenses
                        AddIcomeExpenses(
                          text: "add_expense".tr(), 
                          icon: Icons.remove,
                          onTap: openNewExpenseBox,
                        ),       
                      ],
                    ),
                  
                    // sized box
                    const SizedBox(height: 30,),
                  
                    // income list
                    Text(
                      "income".tr(),
                      style: const TextStyle(),
                    ),
                    // LIST OF INCOME UI
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentMonthIncome.length,
                        itemBuilder: (context, index) {
                        // reverse the shown
                        int reversedIndex = currentMonthIncome.length - 1 - index;

                        // get individual expense
                        Income individualIncome = currentMonthIncome[reversedIndex];
                          
                        // return list tiles
                        return MyListTile(
                          title: individualIncome.name, 
                          trailing: formatDouble(individualIncome.amount),
                          onEditPressed: (context) => openEditIncome(individualIncome),
                          onDeletePressed: (context) => openDeleteIncome(individualIncome),
                          );
                        },
                      ),
                    ),
                  
                    // sized box
                    const SizedBox(height: 30,),
                  
                    // LIST OF EXPENSES UI
                    Text(
                      "expenses".tr(),
                      style: const TextStyle(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentMonthExpense.length,
                        itemBuilder: (context, index) {
                        // reverse the shown
                        int reversedIndex = currentMonthExpense.length - 1 - index;
                    
                        // get individual expense
                        Expense individualExpense = currentMonthExpense[reversedIndex];
                          
                        // return list tiles
                        return MyListTile(
                          title: individualExpense.name, 
                          trailing: formatDouble(individualExpense.amount),
                          onEditPressed: (context) => openEditExpense(individualExpense),
                          onDeletePressed: (context) => openDeleteExpense(individualExpense),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }



// INCOMESSSSSSSSSSSSSS
// CANCEL BUTTON
  Widget _cancelButtonIncome() {
    return MaterialButton(
      onPressed: () {
        // pop 
        Navigator.pop(context);

        // clear textfeilds
        incomeNameController.clear();
        incomeAmountController.clear();

      },
      child: const Text("Cancel"),
    );
  }

  // SAVE BUTTON -> create new expense
  Widget _createNewIncomeButton() {
    return MaterialButton(
      onPressed: () async {
        // only save if there is sth in textfeild
        if (incomeNameController.text.isNotEmpty && incomeAmountController.text.isNotEmpty) {
          // pop the box
          Navigator.pop(context);

          // create new expense 
          Income newIncome = Income(
            name: incomeNameController.text, 
            amount: convertStringToDouble(incomeAmountController.text), 
            date: DateTime.now(),
          );

          // save it to db
          await context.read<IncomeDatabase>().createNewIncome(newIncome);

          // refresh graph
          refreshData();

          // clear the controllers
          incomeNameController.clear();
          incomeAmountController.clear();

        } else {
          
        }
      },
      child: const Text("Save"),
    );
  }

  // SAVE BUTTON -> edit existing expense
  Widget _editIncomeButton(Income income) {
    return MaterialButton(
      onPressed: () async {
        // save if at least one textfeild changed
        if (incomeNameController.text.isNotEmpty || incomeAmountController.text.isNotEmpty) {
          // pop the box
          Navigator.pop(context);

          // create a new expense button
          Income updateIncomes = Income(
            name: incomeNameController.text.isNotEmpty
              ? incomeNameController.text
              : income.name, 
            amount: incomeAmountController.text.isNotEmpty
              ? convertStringToDouble(incomeAmountController.text)
              : income.amount, 
            date: DateTime.now(),
          );

          // old expense id
          int existingId = income.id;

          // save to db
          await context
              .read<IncomeDatabase>()
              .updateIncomes(existingId, updateIncomes);

          // refresh graph
          refreshData();

        } 
      },
      child: const Text("Save"),
    );
  } 

  // DELETE BUTTON -> delete
  Widget _deleteIncomeButton(int id) {
    return MaterialButton(
      onPressed: () async {
        // pop the box
        Navigator.pop(context);

        // delete the expense
        await context.read<IncomeDatabase>().deleteIncome(id);

        // refresh graph
        refreshData();
      },
      child: const Text("Delete"),
    );
  }




// EXPENSESSSSSSSSSSSSSS
// CANCEL BUTTON
  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () {
        // pop 
        Navigator.pop(context);

        // clear textfeilds
        exenseNameController.clear();
        expenseAmountController.clear();

      },
      child: const Text("Cancel"),
    );
  }

  // SAVE BUTTON -> create new expense
  Widget _createNewExpenseButton() {
    return MaterialButton(
      onPressed: () async {
        // only save if there is sth in textfeild
        if (exenseNameController.text.isNotEmpty && expenseAmountController.text.isNotEmpty) {
          // pop the box
          Navigator.pop(context);

          // create new expense 
          Expense newExpense = Expense(
            name: exenseNameController.text, 
            amount: convertStringToDouble(expenseAmountController.text), 
            date: DateTime.now(),
          );

          // save it to db
          await context.read<ExpenseDatabase>().createNewExpense(newExpense);

          // refresh graph
          refreshData();

          // clear the controllers
          exenseNameController.clear();
          expenseAmountController.clear();

        } else {
          
        }
      },
      child: const Text("Save"),
    );
  }

  // SAVE BUTTON -> edit existing expense
  Widget _editExpenseButton(Expense expense) {
    return MaterialButton(
      onPressed: () async {
        // save if at least one textfeild changed
        if (exenseNameController.text.isNotEmpty || expenseAmountController.text.isNotEmpty) {
          // pop the box
          Navigator.pop(context);

          // create a new expense button
          Expense updatedExpense = Expense(
            name: exenseNameController.text.isNotEmpty
              ? exenseNameController.text
              : expense.name, 
            amount: expenseAmountController.text.isNotEmpty
              ? convertStringToDouble(expenseAmountController.text)
              : expense.amount, 
            date: DateTime.now(),
          );

          // old expense id
          int existingId = expense.id;

          // save to db
          await context
              .read<ExpenseDatabase>()
              .updateExpenses(existingId, updatedExpense);

          // refresh graph
          refreshData();

        } 
      },
      child: const Text("Save"),
    );
  } 

  // DELETE BUTTON -> delete
  Widget _deleteExpenseButton(int id) {
    return MaterialButton(
      onPressed: () async {
        // pop the box
        Navigator.pop(context);

        // delete the expense
        await context.read<ExpenseDatabase>().deleteExpense(id);

        // refresh graph
        refreshData();
      },
      child: const Text("Delete"),
    );
  }
}
