import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_owner/blocs/food/food_bloc.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/food_category_selector.dart';
import 'package:restaurant_owner/ui/widgets/food_type_selector.dart';
import 'package:restaurant_owner/util/custom_file_picker.dart';
import 'package:restaurant_owner/util/value_validators.dart';

class AddEditFoodDialog extends StatefulWidget {
  final FoodBloc foodBloc;
  final Map<String, dynamic>? foodDetails;
  const AddEditFoodDialog({
    super.key,
    this.foodDetails,
    required this.foodBloc,
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
  final TextEditingController _calorieController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();

  PlatformFile? selectedFile;
  int? foodTypeId, foodCategoryId;
  String? typeName, categoryName;

  @override
  void initState() {
    if (widget.foodDetails != null) {
      Logger().wtf(widget.foodDetails);
      _nameController.text = widget.foodDetails!['name'];
      _descriptionController.text = widget.foodDetails!['description'];
      _servesCountController.text =
          widget.foodDetails!['serves_count'].toString();
      _priceController.text = widget.foodDetails!['price'].toString();
      _discountedPriceController.text =
          widget.foodDetails!['discounted_price'].toString();
      _calorieController.text = widget.foodDetails!['calories'].toString();
      _cookingTimeController.text = widget.foodDetails!['time'].toString();
      foodTypeId = widget.foodDetails!['type']['id'];
      foodCategoryId = widget.foodDetails!['category']['id'];
      typeName = widget.foodDetails!['type']['type'];
      categoryName = widget.foodDetails!['category']['category'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 700,
      title: widget.foodDetails != null ? "Edit Food" : "Add Food",
      message: widget.foodDetails != null
          ? "Change the following details and save to apply them"
          : "Enter the following details to add a food item.",
      content: Expanded(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: alphaNumericValidator,
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
                  validator: alphaNumericValidator,
                  decoration: const InputDecoration(
                    hintText: 'eg.Decription of the food',
                  ),
                ),
              ),
              const Divider(
                height: 30,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Text(
                'Serves count',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              CustomCard(
                child: TextFormField(
                  controller: _servesCountController,
                  validator: numericValidator,
                  decoration: const InputDecoration(
                    hintText: 'eg.2',
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
                            validator: numericValidator,
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
                            validator: numericValidator,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calories',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomCard(
                          child: TextFormField(
                            controller: _calorieController,
                            validator: alphaNumericValidator,
                            decoration: const InputDecoration(
                              hintText: 'eg.120',
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
                          'Cooking Time',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomCard(
                          child: TextFormField(
                            controller: _cookingTimeController,
                            validator: numericValidator,
                            decoration: const InputDecoration(
                              hintText: 'eg.20 (Time must be in minutes)',
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
                    child: FoodTypeSelector(
                      onSelect: (selectedId) {
                        foodTypeId = selectedId;
                        setState(() {});
                      },
                      label: typeName ?? 'Select Food Type',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FoodCategorySelector(
                      label: categoryName ?? 'Select Food Category',
                      onSelect: (selectedId) {
                        foodCategoryId = selectedId;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              CustomActionButton(
                color: selectedFile != null
                    ? Colors.blue[300]!
                    : Colors.grey[300]!,
                iconData: selectedFile != null
                    ? Icons.check_outlined
                    : Icons.upload_outlined,
                iconColor: selectedFile != null
                    ? Colors.blue[900]!
                    : Colors.grey[900]!,
                onPressed: () async {
                  PlatformFile? file = await pickFile();
                  if (file != null) {
                    selectedFile = file;
                    setState(() {});
                  }
                },
                labelColor: selectedFile != null
                    ? Colors.blue[900]!
                    : Colors.grey[900]!,
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
                      widget.foodBloc.add(
                        EditFoodEvent(
                          name: _nameController.text.toString(),
                          file: selectedFile,
                          description: _descriptionController.text.trim(),
                          calorie: _calorieController.text.trim(),
                          foodCategoryId: foodCategoryId!,
                          foodTypeId: foodTypeId!,
                          time: int.parse(
                              _cookingTimeController.text.trim().toString()),
                          price: int.parse(
                              _priceController.text.trim().toString()),
                          discountedPrice: int.parse(_discountedPriceController
                              .text
                              .trim()
                              .toString()),
                          servesCount: int.parse(
                              _servesCountController.text.trim().toString()),
                          foodId: widget.foodDetails!['id'],
                        ),
                      );

                      Navigator.pop(context);
                    } else {
                      if (selectedFile != null &&
                          foodCategoryId != null &&
                          foodTypeId != null) {
                        widget.foodBloc.add(
                          AddFoodEvent(
                            name: _nameController.text.toString(),
                            file: selectedFile!,
                            description: _descriptionController.text.trim(),
                            calorie: _calorieController.text.trim(),
                            foodCategoryId: foodCategoryId!,
                            foodTypeId: foodTypeId!,
                            time: int.parse(
                                _cookingTimeController.text.trim().toString()),
                            price: int.parse(
                                _priceController.text.trim().toString()),
                            discountedPrice: int.parse(
                                _discountedPriceController.text
                                    .trim()
                                    .toString()),
                            servesCount: int.parse(
                                _servesCountController.text.trim().toString()),
                          ),
                        );

                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: "Required!",
                            message:
                                'Food image, Food category and Food types are required. Please select those to continue',
                            primaryButtonLabel: 'Ok',
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
