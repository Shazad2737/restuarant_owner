import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_owner/blocs/food/food_bloc.dart';
import 'package:restaurant_owner/ui/widgets/add_edit_food_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_progress_indicator.dart';
import 'package:restaurant_owner/ui/widgets/custom_search.dart';
import 'package:restaurant_owner/ui/widgets/food_card.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodBloc foodBloc = FoodBloc();

  String? query;

  void getFoods() {
    foodBloc.add(GetAllFoodEvent(query: query));
  }

  @override
  void initState() {
    getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodBloc>.value(
      value: foodBloc,
      child: BlocConsumer<FoodBloc, FoodState>(
        listener: (context, state) {
          if (state is FoodFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getFoods();
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
                            getFoods();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomActionButton(
                          iconData: Icons.add,
                          label: 'Add Food',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddEditFoodDialog(
                                foodBloc: foodBloc,
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
                    child: state is FoodSuccessState
                        ? state.foods.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.foods.length,
                                    (index) => FoodCard(
                                      foodBloc: foodBloc,
                                      foodDetails: state.foods[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No food found.'))
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
