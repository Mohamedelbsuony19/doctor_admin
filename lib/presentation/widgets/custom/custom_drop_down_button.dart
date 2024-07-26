import 'package:flutter/material.dart';

class CustomDropDownBotton extends StatelessWidget {
  final int value;
  final void Function(Object?)? onChanged;
  const CustomDropDownBotton({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        isExpanded: true,
        value: value,
        hint: const Text("Units"),
        onTap: () {},
        items: List.generate(5, (index) {
          return DropdownMenuItem(
            value: index,
            child: Text("Item $index"),
          );
        }),
        onChanged: onChanged);
  }
}
