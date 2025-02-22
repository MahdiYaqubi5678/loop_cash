import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lp_loopcash/shop/presentation/cart_page.dart';
import 'package:provider/provider.dart';
import '../data/database.dart';
import '../model/shop.dart';
import '../util/dialog_box.dart';
import '../util/my_product_tile.dart';
import '../util/todo_tile.dart';

class ShopUi extends StatefulWidget {
  const ShopUi({super.key});

  @override
  State<ShopUi> createState() => _ShopUiState();
}

class _ShopUiState extends State<ShopUi> {
  

  // Reference the Hive box
  final _shopBox = Hive.box('shopbox');
  final ShopDatabase db = ShopDatabase();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
void initState() {
  super.initState();

  if (!Hive.isBoxOpen('shopbox')) {
    print("🛑 Hive box is NOT open at initState!");
  }

  // 🔹 Check if data exists before using it
  var existingData = _shopBox.get("SHOP_LIST");
  print("🔹 Existing Data in Hive at Startup: $existingData");

  if (existingData != null) {
    db.loadData();
  } else {
    print("🟢 Creating Initial Data...");
    db.createInitialData();
  }

  setState(() {});
}



  void addNewProduct() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          nameController: nameController,
          amountController: priceController,
          onSave: saveProduct,
          onCancel: () => Navigator.of(context).pop(),
          text1: 'product'.tr(),
          text2: 'price'.tr(),
        );
      },
    );
  }

  void saveProduct() {
    setState(() {
      db.shopItems.add([nameController.text, double.parse(priceController.text)]);
      nameController.clear();
      priceController.clear();
    });
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  void deleteProduct(int index) {
    setState(() {
      db.shopItems.removeAt(index);
    });
    db.updateDatabase();
  }


  @override
  Widget build(BuildContext context) {
    //access products in shop
    final products = context.watch<Shop>().shop;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        onPressed: addNewProduct,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              // SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: "search".tr(),
                      ),
                    ),
                  ),
                ),
              ),
              
              // LIST VIEW AND IMAGES
              SizedBox(
                height: 550,
                child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    //get individual product from shop
                    final product = products[index];
                    //return as a product tile UI
                    return MyProductTile(product: product);
                  },
                ),
              ),
              
              // FOR SELL TEXT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "for_sell".tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ),
                        );
                      }, 
                      icon: Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              // LIST VIEW
              ListView.builder(
                shrinkWrap: true, // Add this to make the ListView shrink-wrap its content
                physics: NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
                itemCount: db.shopItems.length,
                itemBuilder: (context, index) {
                  return ShopTile(
                    productName: db.shopItems[index][0],
                    productPrice: db.shopItems[index][1],
                    deleteProduct: () => deleteProduct(index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
