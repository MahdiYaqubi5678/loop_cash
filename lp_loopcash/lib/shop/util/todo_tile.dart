import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShopTile extends StatelessWidget {
  final String productName;
  final double productPrice;
  final VoidCallback deleteProduct;

  ShopTile({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.deleteProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Reduced padding
      padding: const EdgeInsets.all(4.0), // Adjust this value as needed
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deleteProduct(),
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          // Reduced margin
          margin: const EdgeInsets.all(2.0), // Adjust this value as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: ListTile(
            title: Text(
              productName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            trailing: Text("\$${productPrice.toStringAsFixed(2)}"),
          ),
        ),
      ),
    );
  }
}
