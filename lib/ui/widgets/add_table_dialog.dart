import 'package:flutter/material.dart';
import 'package:restaurant_owner/blocs/table/table_bloc.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/util/value_validators.dart';

class AddTableDialog extends StatefulWidget {
  final TableBloc tableBloc;
  const AddTableDialog({super.key, required this.tableBloc});

  @override
  State<AddTableDialog> createState() => _AddTableDialogState();
}

class _AddTableDialogState extends State<AddTableDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: 'Add Table',
      message: 'Enter the following details to add a table',
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Table Name',
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
                  hintText: 'eg.12',
                ),
              ),
            ),
          ],
        ),
      ),
      primaryButtonLabel: 'Add',
      primaryOnPressed: () {
        if (_formKey.currentState!.validate()) {
          widget.tableBloc.add(
            AddTableEvent(
              name: _nameController.text.trim(),
            ),
          );

          Navigator.pop(context);
        }
      },
    );
  }
}
