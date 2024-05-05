import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

class MyCheckBox extends StatelessWidget {
  final String label;
  final bool? value;
  final void Function(bool?)? onChanged;

  const MyCheckBox(
      {Key? key, required this.value, required this.label, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 10,
        ), //SizedBox
        Text(
          label,
          style: const TextStyle(fontSize: 19.0, color: AppStyles.logoColor),
        ), //Text
        const SizedBox(width: 10), //SizedBox
        /** Checkbox Widget **/
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
              value: value,
              activeColor: AppStyles.logoColor,
              checkColor: AppStyles.notActiveDarkC,
              onChanged: onChanged),
        ), //Checkbox
      ], //<Widget>[]
    );
  }
}
