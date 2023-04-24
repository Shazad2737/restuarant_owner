import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/food_item.dart';

class ShowItemsDialog extends StatefulWidget {
  final dynamic orderItemDetails;
  const ShowItemsDialog({super.key, required this.orderItemDetails});

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
      content: Flexible(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => FoodItem(
            foodItemDetails: widget.orderItemDetails['items'][index],
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: widget.orderItemDetails['items'].length,
        ),
      ),
    );
  }
}
