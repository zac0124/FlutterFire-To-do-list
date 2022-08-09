import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SegmentedSelector extends StatelessWidget {
  SegmentedSelector(
      {required this.menuOptions,
      required this.selectedOption,
      required this.onValueChanged});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(dynamic) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        groupValue: selectedOption,
        children: Map.fromIterable(
          menuOptions,
          key: (option) => option.key,
          value: (option) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(option.icon),
              SizedBox(width: 6),
              Text(option.value),
            ],
          ),
        ),
        onValueChanged: onValueChanged);
  }
}
