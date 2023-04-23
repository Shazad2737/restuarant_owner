import 'package:flutter/material.dart';
import 'package:restaurant_owner/blocs/food_type/food_type_bloc.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';

class FoodTypeCard extends StatelessWidget {
  final Map<String, dynamic> foodTypeDetails;
  final FoodTypeBloc foodTypeBloc;
  const FoodTypeCard({
    super.key,
    required this.foodTypeDetails,
    required this.foodTypeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: CustomCard(
        hoverBorderColor: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Text(
                foodTypeDetails['type'],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    foodTypeBloc.add(DeleteFoodTypeEvent(
                      id: foodTypeDetails['id'],
                    ));
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
