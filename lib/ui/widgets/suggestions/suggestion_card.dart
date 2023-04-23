import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';

class SuggestionCard extends StatelessWidget {
  final Map<String, dynamic> suggestionDetails;
  const SuggestionCard({
    super.key,
    required this.suggestionDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${suggestionDetails['id'].toString()}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy hh:mm a').format(
                      DateTime.parse(
                        suggestionDetails['created_at'],
                      ).toLocal(),
                    ),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black,
                        ),
                  )
                ],
              ),
              const Divider(
                height: 30,
              ),
              Text(
                suggestionDetails['suggestion'].toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
