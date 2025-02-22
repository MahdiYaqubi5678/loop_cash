import 'package:hive/hive.dart';

class ShopDatabase {
  final Box _shopBox = Hive.box('shopbox');

  List shopItems = [];

  void createInitialData() {
    shopItems = [
      ["Laptop", 999.99],
      ["Headphones", 59.99],
      ["Smartphone", 699.99],
    ];
    updateDatabase();
  }

  void loadData() {
    var rawData = _shopBox.get("SHOP_LIST");
    print("🔹 Data loaded from Hive: $rawData"); // Debugging print

    if (rawData != null) {
      shopItems = List<List<dynamic>>.from(rawData);
    } else {
      shopItems = [];
    }
  }


  void updateDatabase() {
    _shopBox.put("SHOP_LIST", shopItems);
    print("🔹 Data saved to Hive: ${_shopBox.get("SHOP_LIST")}");
  }
}
