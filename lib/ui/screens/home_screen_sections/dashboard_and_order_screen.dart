import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_action_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/custom_search.dart';
import 'package:restaurant_owner/ui/widgets/show_items_dialog.dart';

class DashboardAndOrderScreen extends StatefulWidget {
  const DashboardAndOrderScreen({super.key});

  @override
  State<DashboardAndOrderScreen> createState() =>
      _DashboardAndOrderScreenState();
}

class _DashboardAndOrderScreenState extends State<DashboardAndOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                DashboardCard(
                  label: 'Today\'s Orders',
                  title: '20',
                  icon: Icons.sell_outlined,
                ),
                DashboardCard(
                  label: 'Total Food Items',
                  title: '100',
                  icon: Icons.food_bank_outlined,
                ),
                DashboardCard(
                  label: 'Total Complaints',
                  title: '30',
                  icon: Icons.report_outlined,
                ),
                DashboardCard(
                  label: 'Total Tables',
                  title: '40',
                  icon: Icons.table_bar_outlined,
                ),
              ],
            ),

            const Divider(
              height: 30,
            ),
            CustomSearch(
              onSearch: (search) {},
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                OrderItem(
                  isSeleted: true,
                  label: 'Orderd',
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                OrderItem(
                  isSeleted: false,
                  label: 'Delivered',
                  onTap: () {},
                ),
              ],
            ),
            const Divider(
              height: 40,
            ),

            Expanded(
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                columns: [
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "#ID",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Date",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Table",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Name",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Phone",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Total Price",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Status",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.L,
                    label: Text(
                      "Actions",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  20,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          index.toString(),
                        ),
                      ),
                      const DataCell(
                        Text(
                          "19/04/2023",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "C2",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "User name",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "9876543210",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "₹1500",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "Pending",
                        ),
                      ),
                      DataCell(
                        Wrap(
                          spacing: 10,
                          children: [
                            CustomActionButton(
                              iconData: Icons.arrow_outward_outlined,
                              mainAxisSize: MainAxisSize.min,
                              label: 'Items',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const ShowItemsDialog(),
                                );
                              },
                              color: Colors.green[700]!,
                            ),
                            CustomActionButton(
                              iconData: Icons.check,
                              mainAxisSize: MainAxisSize.min,
                              label: 'Accepted',
                              onPressed: () {},
                              color: Colors.blue[700]!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 40,
            // ),
          ],
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
