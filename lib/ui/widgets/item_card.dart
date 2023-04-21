import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';

class ItemCard extends StatelessWidget {
  final Color? hoverColor;
  final bool isOnDialog;
  final String label;
  const ItemCard({
    super.key,
    this.hoverColor = Colors.green,
    this.isOnDialog = false,
    this.label = 'Meal',
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      hoverBorderColor: hoverColor!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
