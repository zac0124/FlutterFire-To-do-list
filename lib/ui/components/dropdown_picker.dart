import 'package:flutter/material.dart';

class DropDownPicker extends StatelessWidget {
  DropDownPicker(
      {required this.menuOptions,
      required this.onChanged,
      required this.selectedOption});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        items: menuOptions
            .map((data) => DropdownMenuItem<String>(
                  child: Text(data.value),
                  value: data.key,
                ))
            .toList(),
        value: selectedOption,
        onChanged: onChanged);
  }
}
