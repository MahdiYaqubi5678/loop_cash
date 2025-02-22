import 'package:flutter/material.dart';

class AddIcomeExpenses extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const AddIcomeExpenses({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // paddings
      padding: const EdgeInsets.symmetric(horizontal: 10.0),

      // container
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 110,
          width: 230,
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
              
              const SizedBox(width: 20,),
                                      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}