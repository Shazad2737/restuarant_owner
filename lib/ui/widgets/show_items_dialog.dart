import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/food_item.dart';

class ShowItemsDialog extends StatefulWidget {
  const ShowItemsDialog({super.key});

  @override
  State<ShowItemsDialog> createState() => _ShowItemsDialogState();
}

class _ShowItemsDialogState extends State<ShowItemsDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      message: 'Items ordered by customer',
      title: 'Items',
      content: Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => const FoodItem(),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: 1,
        ),
      ),
    );
  }
}
