import 'package:flutter/material.dart';
import 'package:restaurant_owner/blocs/table/table_bloc.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';

class TableCard extends StatelessWidget {
  final TableBloc tableBloc;
  final Map<String, dynamic> tableDetails;
  const TableCard({
    super.key,
    required this.tableBloc,
    required this.tableDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: CustomCard(
        hoverBorderColor: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Text(
                tableDetails['name'],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    tableBloc.add(
                      DeleteTableEvent(id: tableDetails['id']),
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
