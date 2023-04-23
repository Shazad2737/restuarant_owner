import 'package:flutter/material.dart';
import 'package:restaurant_owner/blocs/food_category/food_category_bloc.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';

class CategoryCard extends StatelessWidget {
  final FoodCategoryBloc foodCategoryBloc;
  final Map<String, dynamic> categoryDetails;
  const CategoryCard({
    super.key,
    required this.foodCategoryBloc,
    required this.categoryDetails,
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
                '#${categoryDetails['id'].toString()}',
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
                    categoryDetails['image_url'],
                    height: 280,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                categoryDetails['category'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 30,
              ),
              CustomActionButton(
                iconData: Icons.delete_forever_outlined,
                color: Colors.red[700]!,
                label: 'Delete',
                onPressed: () {
                  foodCategoryBloc.add(
                    DeleteFoodCategoryEvent(
                      id: categoryDetails['id'],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
