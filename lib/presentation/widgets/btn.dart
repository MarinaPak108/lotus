import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class MyBtn extends StatelessWidget {
  final String name;
  final double? width;
  final void Function()? onPressed;

  const MyBtn({Key? key, required this.name, this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: global.globalWidth * 3.5,
      height: MediaQuery.sizeOf(context).height / 10,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(4.0),
              disabledBackgroundColor: AppStyles.backgroundLogoColor,
              backgroundColor: AppStyles.logoColor),
          onPressed: onPressed,
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
