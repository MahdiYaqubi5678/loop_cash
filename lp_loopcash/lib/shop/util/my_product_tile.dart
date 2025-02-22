
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/products.dart';
import '../model/shop.dart';

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({
    super.key,
    required this.product,
  });

  //add to cart button
  void addToCart(BuildContext context){
    //show a dialog box to confirm that user want or no
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: Text("sure_to_add".tr()),
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

              //add to cart
              context.read<Shop>().addToCart(product);
            }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //product image
             AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  child: Image.asset(
                    product.imagePath,
                    height: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 10,),

              //product name
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),

             //product description
              Text(
                product.description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),

          
          SizedBox(height: 10,),

          //product price + button to add to cart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              //product price
              Text('${product.price.toStringAsFixed(2)}'),

              //button to add to cart
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => addToCart(context), 
                  icon: Icon(Icons.add),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}