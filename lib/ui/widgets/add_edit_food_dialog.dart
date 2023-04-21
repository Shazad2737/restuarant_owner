import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/util/custom_file_picker.dart';

class AddEditFoodDialog extends StatefulWidget {
  final Map<String, dynamic>? foodDetails;
  const AddEditFoodDialog({
    super.key,
    this.foodDetails,
  });

  @override
  State<AddEditFoodDialog> createState() => _AddEditFoodDialogState();
}

class _AddEditFoodDialogState extends State<AddEditFoodDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountedPriceController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _servesCountController = TextEditingController();

  PlatformFile? selectedFile;

  @override
  void initState() {
    if (widget.foodDetails != null) {
      _nameController.text = widget.foodDetails!['name'];
      _descriptionController.text = widget.foodDetails!['description'];
      _servesCountController.text =
          widget.foodDetails!['serves_count'].toString();
      _priceController.text = widget.foodDetails!['price'].toString();
      _discountedPriceController.text =
          widget.foodDetails!['discounted_price'].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: widget.foodDetails != null ? "Edit Food" : "Add Food",
      message: widget.foodDetails != null
          ? "Change the following details and save to apply them"
          : "Enter the following details to add a food item.",
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Name',
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
                    return 'Please enter Name';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'eg.Pizza',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Description',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            CustomCard(
              child: TextFormField(
                maxLines: 2,
                controller: _descriptionController,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter description';
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'eg.Decription of the food',
                ),
              ),
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 5),
                      CustomCard(
                        child: TextFormField(
                          controller: _priceController,
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              return null;
                            } else {
                              return 'Please enter price';
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Price in rupees',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discounted Price',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 5),
                      CustomCard(
                        child: TextFormField(
                          controller: _discountedPriceController,
                          validator: (value) {
                            if ((value != null && value.trim().isNotEmpty) ||
                                widget.foodDetails != null) {
                              return null;
                            } else {
                              return 'Please enter discounted price';
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Price in rupees',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomActionButton(
                    color: Colors.grey[300]!,
                    labelColor: Colors.grey[900]!,
                    iconColor: Colors.grey[900]!,
                    iconData: Icons.restaurant_outlined,
                    label: 'Food Type',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomActionButton(
                    color: Colors.grey[300]!,
                    labelColor: Colors.grey[900]!,
                    iconColor: Colors.grey[900]!,
                    iconData: Icons.restaurant_outlined,
                    label: 'Food Category',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
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
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            CustomButton(
              buttonColor: Colors.green[700],
              labelColor: Colors.white,
              label: widget.foodDetails != null ? 'Save' : 'Add',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.foodDetails != null) {
                    // BlocProvider.of<PatientBloc>(context).add(
                    //   EditPatientEvent(
                    //     patientId: widget.patientDetails!['id'],
                    //     name: _nameController.text.trim(),
                    //     phone: _phoneNumberController.text.trim(),
                    //     address: _addressController.text.trim(),
                    //     city: _cityController.text.trim(),
                    //     district: _districtController.text.trim(),
                    //     dob: _dob!,
                    //     gender: _gender,
                    //     state: _stateController.text.trim(),
                    //   ),
                    // );
                  } else {
                    // BlocProvider.of<PatientBloc>(context).add(
                    //   AddPatientEvent(
                    //     name: _nameController.text.trim(),
                    //     phone: _phoneNumberController.text.trim(),
                    //     address: _addressController.text.trim(),
                    //     city: _cityController.text.trim(),
                    //     district: _districtController.text.trim(),
                    //     dob: _dob!,
                    //     gender: _gender,
                    //     state: _stateController.text.trim(),
                    //   ),
                    // );
                  }

                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
