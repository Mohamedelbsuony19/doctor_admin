import 'package:flutter/material.dart';

class EnterToSearchWidget extends StatelessWidget {
  const EnterToSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search,
          size: 100,
          color: Colors.grey,
        ),
        SizedBox(height: 20),
        Text(
          'Please enter a search term.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
