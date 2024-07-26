import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning,
          size: 100,
          color: Colors.grey,
        ),
        SizedBox(height: 20),
        Text(
          'No results found.',
          style: TextStyle(
              fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
