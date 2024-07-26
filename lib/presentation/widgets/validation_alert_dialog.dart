import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showValidationDialog(BuildContext context,
    {String validationName = "Delete",
    required String itemName,
    required Function onYesPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm $validationName'),
        content: Text(
            'Are you sure you want to ${validationName.substring(0, 1).toLowerCase() + validationName.substring(1)} $itemName'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              // Handle delete action
              await onYesPressed.call();
              if (context.mounted) {
                context.pop();
              }
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      );
    },
  );
}
