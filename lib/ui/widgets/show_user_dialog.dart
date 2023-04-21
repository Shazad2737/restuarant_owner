import 'package:flutter/material.dart';
import 'package:restaurant_owner/ui/widgets/custom_alert_dialog.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/user/user_card.dart';

class ShowUserDialog extends StatefulWidget {
  const ShowUserDialog({super.key});

  @override
  State<ShowUserDialog> createState() => _ShowUserDialogState();
}

class _ShowUserDialogState extends State<ShowUserDialog> {
  @override
  Widget build(BuildContext context) {
    return const CustomAlertDialog(
      title: 'Details',
      message: 'User details',
      content: UserCard(),
    );
  }
}
