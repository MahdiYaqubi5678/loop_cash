import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lp_loopcash/shop/util/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController amountController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String text1;
  final String text2;

  const DialogBox({
    super.key,
    required this.nameController,
    required this.amountController,
    required this.onSave,
    required this.onCancel,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("add_product".tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: InputDecoration(labelText: text1)),
          TextField(controller: amountController, decoration: InputDecoration(labelText: text2)),
        ],
      ),
      actions: [
        MyButton(
          onPressed: onCancel, 
          text: "cancel".tr(),
        ),
        MyButton(
          onPressed: onSave, 
          text: "save".tr(),
        ),
      ],
    );
  }
}
