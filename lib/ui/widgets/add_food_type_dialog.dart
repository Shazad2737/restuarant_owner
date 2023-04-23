import 'package:flutter/material.dart';
import 'package:restaurant_owner/blocs/food_type/food_type_bloc.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/util/value_validators.dart';

class AddFoodTypeDialog extends StatefulWidget {
  final FoodTypeBloc foodTypeBloc;
  const AddFoodTypeDialog({super.key, required this.foodTypeBloc});

  @override
  State<AddFoodTypeDialog> createState() => _AddFoodTypeDialogState();
}

class _AddFoodTypeDialogState extends State<AddFoodTypeDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: 'Add Type',
      message: 'Enter the following details to add a food type',
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food Type',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            CustomCard(
              child: TextFormField(
                controller: _nameController,
                validator: alphaNumericValidator,
                decoration: const InputDecoration(
                  hintText: 'eg.Meal',
                ),
              ),
            ),
          ],
        ),
      ),
      primaryButtonLabel: 'Add',
      primaryOnPressed: () {
        if (_formKey.currentState!.validate()) {
          widget.foodTypeBloc.add(AddFoodTypeEvent(
            name: _nameController.text.trim(),
          ));

          Navigator.pop(context);
        }
      },
    );
  }
}
