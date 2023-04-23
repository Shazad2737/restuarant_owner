import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_owner/blocs/food_category/food_category_bloc.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';
import 'custom_select_box.dart';

class FoodCategorySelector extends StatefulWidget {
  final Function(int) onSelect;
  final String label;
  const FoodCategorySelector({
    super.key,
    required this.onSelect,
    required this.label,
  });

  @override
  State<FoodCategorySelector> createState() => _FoodCategorySelectorState();
}

class _FoodCategorySelectorState extends State<FoodCategorySelector> {
  final FoodCategoryBloc categoryBloc = FoodCategoryBloc();

  @override
  void initState() {
    categoryBloc.add(GetAllFoodCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<FoodCategoryBloc>.value(
        value: categoryBloc,
        child: BlocConsumer<FoodCategoryBloc, FoodCategoryState>(
          listener: (context, state) {
            if (state is FoodCategoryFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    categoryBloc.add(GetAllFoodCategoryEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is FoodCategorySuccessState) {
              return CustomSelectBox(
                iconData: Icons.category_outlined,
                items: List<CustomSelectBoxItem>.generate(
                  state.categories.length,
                  (index) => CustomSelectBoxItem(
                    value: state.categories[index]['id'],
                    label: state.categories[index]['category'],
                  ),
                ),
                label: widget.label,
                onChange: (selected) {
                  widget.onSelect(selected != null ? selected.value : 0);
                },
              );
            } else if (state is FoodCategoryFailureState) {
              return const SizedBox();
            } else {
              return const SizedBox(
                width: 100,
                child: SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
