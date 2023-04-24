import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_owner/blocs/dashboard_count/dashboard_count_bloc.dart';
import 'package:restaurant_owner/blocs/manage_orders/manage_orders_bloc.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/custom_progress_indicator.dart';
import 'package:restaurant_owner/ui/widgets/custom_search.dart';
import 'package:restaurant_owner/ui/widgets/show_items_dialog.dart';

import '../../widgets/custom_alert_dialog.dart';

class DashboardAndOrderScreen extends StatefulWidget {
  const DashboardAndOrderScreen({super.key});

  @override
  State<DashboardAndOrderScreen> createState() =>
      _DashboardAndOrderScreenState();
}

class _DashboardAndOrderScreenState extends State<DashboardAndOrderScreen> {
  final ManageOrdersBloc manageOrdersBloc = ManageOrdersBloc();
  final DashboardCountBloc dashboardCountBloc = DashboardCountBloc();

  String status = 'pending';

  void getOrders() {
    manageOrdersBloc.add(GetAllManageOrdersEvent(status: status));
    dashboardCountBloc.add(DashboardCountEvent());
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<ManageOrdersBloc>.value(
        value: manageOrdersBloc,
        child: BlocProvider<DashboardCountBloc>.value(
          value: dashboardCountBloc,
          child: BlocConsumer<ManageOrdersBloc, ManageOrdersState>(
            listener: (context, state) {
              if (state is ManageOrdersFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failed',
                    message: state.message,
                    primaryButtonLabel: 'Ok',
                    primaryOnPressed: () {
                      getOrders();
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<DashboardCountBloc, DashboardCountState>(
                      listener: (context, dbcState) {
                        if (dbcState is DashboardCountFailureState) {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: 'Failed',
                              message: dbcState.message,
                              primaryButtonLabel: 'Ok',
                              primaryOnPressed: () {
                                dashboardCountBloc.add(DashboardCountEvent());
                              },
                            ),
                          );
                        }
                      },
                      builder: (context, dbcState) {
                        return dbcState is DashboardCountSuccessState
                            ? Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  DashboardCard(
                                    label: 'Total Sales',
                                    title: dbcState.dashbordCount['sales']
                                        .toString(),
                                    icon: Icons.sell_outlined,
                                  ),
                                  DashboardCard(
                                    label: 'Total Orders',
                                    title: dbcState.dashbordCount['order_count']
                                        .toString(),
                                    icon: Icons.food_bank_outlined,
                                  ),
                                  DashboardCard(
                                    label: 'Total Food Items',
                                    title: dbcState
                                        .dashbordCount['food_items_count']
                                        .toString(),
                                    icon: Icons.report_outlined,
                                  ),
                                  DashboardCard(
                                    label: 'Total Tables',
                                    title: dbcState.dashbordCount['table_count']
                                        .toString(),
                                    icon: Icons.table_bar_outlined,
                                  ),
                                ],
                              )
                            : const Center(child: CustomProgressIndicator());
                      },
                    ),

                    const Divider(
                      height: 30,
                    ),

                    Row(
                      children: [
                        OrderItem(
                          isSeleted: status == 'pending',
                          label: 'Orderd',
                          onTap: () {
                            status = 'pending';
                            getOrders();
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        OrderItem(
                          isSeleted: status == 'complete',
                          label: 'Delivered',
                          onTap: () {
                            status = 'complete';
                            getOrders();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      height: 40,
                    ),

                    Expanded(
                      child: state is ManageOrdersSuccessState
                          ? state.orders.isNotEmpty
                              ? DataTable2(
                                  columnSpacing: 12,
                                  horizontalMargin: 12,
                                  columns: [
                                    DataColumn2(
                                      size: ColumnSize.S,
                                      fixedWidth: 60,
                                      label: Text(
                                        "#ID",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.M,
                                      label: Text(
                                        "Date",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.S,
                                      fixedWidth: 100,
                                      label: Text(
                                        "Table",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.M,
                                      label: Text(
                                        "Name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.M,
                                      label: Text(
                                        "Phone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.S,
                                      label: Text(
                                        "Total Price",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.L,
                                      label: Text(
                                        "Actions",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                  rows: List<DataRow>.generate(
                                    state.orders.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            state.orders[index]['id']
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            DateFormat('dd/MM/yyyy hh:mm a')
                                                .format(DateTime.parse(
                                                        state.orders[index]
                                                            ['created_at'])
                                                    .toLocal()),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            state.orders[index]['table']
                                                ['name'],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            state.orders[index]['user']['name'],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            state.orders[index]['user']
                                                ['phone'],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "₹${state.orders[index]['total'].toString()}",
                                          ),
                                        ),
                                        DataCell(
                                          Wrap(
                                            spacing: 10,
                                            children: [
                                              CustomActionButton(
                                                iconData: Icons
                                                    .arrow_outward_outlined,
                                                mainAxisSize: MainAxisSize.min,
                                                label: 'Items',
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        ShowItemsDialog(
                                                      orderItemDetails:
                                                          state.orders[index],
                                                    ),
                                                  );
                                                },
                                                color: Colors.green[700]!,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text('No Orders Found'),
                                )
                          : const Center(
                              child: CustomProgressIndicator(),
                            ),
                    ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label, title;
  final IconData icon;
  const DashboardCard({
    super.key,
    required this.label,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.green[800],
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.green[800],
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Function() onTap;
  final String label;
  final bool isSeleted;
  const OrderItem({
    super.key,
    required this.onTap,
    required this.label,
    required this.isSeleted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onTap,
      color: isSeleted ? Colors.green[800] : Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isSeleted ? Colors.white : Colors.green,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
