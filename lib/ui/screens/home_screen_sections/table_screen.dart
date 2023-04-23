import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_owner/blocs/table/table_bloc.dart';
import 'package:restaurant_owner/ui/widgets/add_table_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_progress_indicator.dart';
import 'package:restaurant_owner/ui/widgets/custom_search.dart';
import 'package:restaurant_owner/ui/widgets/table_card.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  TableBloc tableBloc = TableBloc();

  String? query;

  void getTables() {
    tableBloc.add(
      GetAllTableEvent(
        query: query,
      ),
    );
  }

  @override
  void initState() {
    getTables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TableBloc>.value(
      value: tableBloc,
      child: BlocConsumer<TableBloc, TableState>(
        listener: (context, state) {
          if (state is TableFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getTables();
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
                            getTables();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomActionButton(
                          iconData: Icons.add,
                          label: 'Add Table',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddTableDialog(
                                tableBloc: tableBloc,
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
                    child: state is TableSuccessState
                        ? state.tables.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.tables.length,
                                    (index) => TableCard(
                                      tableBloc: tableBloc,
                                      tableDetails: state.tables[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No tables found.'))
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
