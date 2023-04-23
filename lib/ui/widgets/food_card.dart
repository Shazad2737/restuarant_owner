import 'package:flutter/material.dart';
import 'package:restaurant_owner/blocs/food/food_bloc.dart';
import 'package:restaurant_owner/ui/widgets/add_edit_food_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/label_with_text.dart';

class FoodCard extends StatelessWidget {
  final FoodBloc foodBloc;
  final Map<String, dynamic> foodDetails;
  const FoodCard({
    super.key,
    required this.foodBloc,
    required this.foodDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      hoverBorderColor: Colors.green,
      child: SizedBox(
        width: 310,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#${foodDetails['id'].toString()}',
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
                    foodDetails['image_url'],
                    height: 180,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Title',
                text: foodDetails['name'],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Description',
                text: foodDetails['description'],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Food Type',
                      text: foodDetails['type']['type'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Food Category',
                      text: foodDetails['category']['category'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Calorie',
                      text: foodDetails['calories'].toString(),
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Cooking Time',
                      text: '${foodDetails['time'].toString()} Minutes',
                    ),
                  ),
                ],
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
                    '₹${foodDetails['price'].toString()}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.red[800],
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '₹${foodDetails['discounted_price'].toString()}',
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
                      onPressed: () {
                        foodBloc.add(
                          DeleteFoodEvent(
                            id: foodDetails['id'],
                          ),
                        );
                      },
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
                          builder: (context) => AddEditFoodDialog(
                            foodBloc: foodBloc,
                            foodDetails: foodDetails,
                          ),
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
