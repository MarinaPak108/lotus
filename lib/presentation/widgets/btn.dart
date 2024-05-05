import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

class MyBtn extends StatelessWidget {
  final String name;
  final void Function()? onPressed;

  const MyBtn({Key? key, required this.name, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2.5,
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
