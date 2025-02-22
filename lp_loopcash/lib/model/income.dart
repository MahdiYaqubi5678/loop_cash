import 'package:isar/isar.dart';

// line for generator
part 'income.g.dart';

@Collection()

class Income {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final DateTime date;

  Income({
    required this.name,
    required this.amount,
    required this.date
  });
}