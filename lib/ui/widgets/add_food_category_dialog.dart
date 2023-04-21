import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/util/custom_file_picker.dart';

class AddFoodCategoryDialog extends StatefulWidget {
  const AddFoodCategoryDialog({super.key});

  @override
  State<AddFoodCategoryDialog> createState() => _AddFoodCategoryDialogState();
}

class _AddFoodCategoryDialogState extends State<AddFoodCategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  PlatformFile? selectedFile;
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: 'Add Category',
      message: 'Enter the following details to add a food category',
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Name',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            CustomCard(
              child: TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter category name';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'eg.Fast Food',
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomActionButton(
              color:
                  selectedFile != null ? Colors.blue[300]! : Colors.grey[300]!,
              iconData: selectedFile != null
                  ? Icons.check_outlined
                  : Icons.upload_outlined,
              iconColor:
                  selectedFile != null ? Colors.blue[900]! : Colors.grey[900]!,
              onPressed: () async {
                PlatformFile? file = await pickFile();
                if (file != null) {
                  selectedFile = file;
                  setState(() {});
                }
              },
              labelColor:
                  selectedFile != null ? Colors.blue[900]! : Colors.grey[900]!,
              label: selectedFile != null ? 'Added' : 'Add Image',
            ),
          ],
        ),
      ),
      primaryButtonLabel: 'Add',
      primaryOnPressed: () {
        if (_formKey.currentState!.validate()) {
          if (selectedFile != null) {
          } else {
            showDialog(
              context: context,
              builder: (context) => const CustomAlertDialog(
                title: 'Required!',
                message: 'Food category image is required',
                primaryButtonLabel: 'Ok',
              ),
            );
          }
        }
      },
    );
  }
}
