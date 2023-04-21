import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/add_edit_food_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/label_with_text.dart';

class FoodCard extends StatelessWidget {
  final Color? hoverColor;
  final bool isOnDialog;
  const FoodCard({
    super.key,
    this.hoverColor = Colors.green,
    this.isOnDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      hoverBorderColor: hoverColor!,
      child: SizedBox(
        width: 310,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#12',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=481&q=80',
                    height: 280,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Title',
                text: 'Pizza',
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Description',
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sapien eget sem ornare lacinia quis a sapien.',
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Food Type',
                text: 'Meal',
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Food Category',
                text: 'Fast Food',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Price',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹200',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.red[800],
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '₹150',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.delete_forever_outlined,
                      color: Colors.red[900]!,
                      label: 'Delete',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.edit_outlined,
                      color: Colors.blue,
                      label: 'Edit',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AddEditFoodDialog(),
                        );
                      },
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
