import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/products.dart';
import '../model/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //remove item from cart
  void removeItemFromCart(BuildContext context, Product product) {

    //show a dialog box to confirm that user want to remove or no
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: Text("sure_to_remove".tr()),
        actions: [

          //cancel
          MaterialButton(
            child: Text("cancel".tr()),
            onPressed: () => Navigator.pop(context),
          ),

          //yes
          MaterialButton(
            child: Text("yes".tr()),
            onPressed: () { 

              //pop dialog box
              Navigator.pop(context);

              //remove from cart
              context.read<Shop>().removeFromCart(product);
            }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //get access to cart
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text("cart".tr())),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          //cart list
          Expanded(
            child: cart.isEmpty
          ? Center(child: Text("cart_empty".tr()))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                //get indvidual item to cart
                final item = cart[index];
                //return as a cart tile UI
                return Container(
                  margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
                  height: 65,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.price.toStringAsFixed(2)),
                    trailing: IconButton(
                      onPressed: () => removeItemFromCart(context, item), 
                      icon: Icon(Icons.remove),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}