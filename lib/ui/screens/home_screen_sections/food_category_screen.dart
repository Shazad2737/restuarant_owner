import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_owner/blocs/food_category/food_category_bloc.dart';
import 'package:restaurant_owner/ui/widgets/add_food_category_dialog.dart';
import 'package:restaurant_owner/ui/widgets/category_card.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_progress_indicator.dart';
import 'package:restaurant_owner/ui/widgets/custom_search.dart';

class FoodCategoryScreen extends StatefulWidget {
  const FoodCategoryScreen({super.key});

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  final FoodCategoryBloc foodCategoryBloc = FoodCategoryBloc();

  String? query;

  void getCategories() {
    foodCategoryBloc.add(GetAllFoodCategoryEvent(query: query));
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodCategoryBloc>.value(
      value: foodCategoryBloc,
      child: BlocConsumer<FoodCategoryBloc, FoodCategoryState>(
        listener: (context, state) {
          if (state is FoodCategoryFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getCategories();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomSearch(
                          onSearch: (search) {
                            query = search;
                            getCategories();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomActionButton(
                          iconData: Icons.add,
                          label: 'Add Category',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddFoodCategoryDialog(
                                foodCategoryBloc: foodCategoryBloc,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is FoodCategorySuccessState
                        ? state.categories.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.categories.length,
                                    (index) => CategoryCard(
                                      foodCategoryBloc: foodCategoryBloc,
                                      categoryDetails: state.categories[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text('No food categories found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
