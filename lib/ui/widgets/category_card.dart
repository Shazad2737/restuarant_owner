import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';

class CategoryCard extends StatelessWidget {
  final Color? hoverColor;
  final bool isOnDialog;
  const CategoryCard({
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
              Text(
                'Fast Food',
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
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
