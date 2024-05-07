import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    double width = MediaQuery.sizeOf(context).width / 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: width * 0.1,
        ), //SizedBox
        LimitedBox(
          maxWidth: width * 7,
          child: Text(
            maxLines: 2,
            label,
            style: TextStyle(
              fontSize: width * 0.4,
              color: AppStyles.logoColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ), //Text
        SizedBox(width: width * 0.2), //SizedBox
        /** Checkbox Widget **/
        Transform.scale(
          scale: width * 0.035,
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
