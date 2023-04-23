import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_owner/blocs/food_type/food_type_bloc.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';
import 'custom_select_box.dart';

class FoodTypeSelector extends StatefulWidget {
  final Function(int) onSelect;
  final String label;
  const FoodTypeSelector({
    super.key,
    required this.onSelect,
    required this.label,
  });

  @override
  State<FoodTypeSelector> createState() => _FoodTypeSelectorState();
}

class _FoodTypeSelectorState extends State<FoodTypeSelector> {
  final FoodTypeBloc categoryBloc = FoodTypeBloc();

  @override
  void initState() {
    categoryBloc.add(GetAllFoodTypeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<FoodTypeBloc>.value(
        value: categoryBloc,
        child: BlocConsumer<FoodTypeBloc, FoodTypeState>(
          listener: (context, state) {
            if (state is FoodTypeFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    categoryBloc.add(GetAllFoodTypeEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is FoodTypeSuccessState) {
              return CustomSelectBox(
                iconData: Icons.restaurant,
                items: List<CustomSelectBoxItem>.generate(
                  state.types.length,
                  (index) => CustomSelectBoxItem(
                    value: state.types[index]['id'],
                    label: state.types[index]['type'],
                  ),
                ),
                label: widget.label,
                onChange: (selected) {
                  widget.onSelect(selected != null ? selected.value : 0);
                },
              );
            } else if (state is FoodTypeFailureState) {
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
