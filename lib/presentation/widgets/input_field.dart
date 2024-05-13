import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class MyInputField extends StatelessWidget {
  final String label;
  final TextEditingController? ctrl;
  final bool isPwdVisible;
  final IconButton? icn;
  final int lines;

  const MyInputField(
      {Key? key,
      required this.label,
      this.ctrl,
      this.isPwdVisible = false,
      this.lines = 1,
      this.icn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = global.globalHeight;
    return TextField(
      maxLines: lines,
      obscureText: isPwdVisible,
      style:
          const TextStyle(color: Color.fromARGB(255, 47, 47, 47), fontSize: 25),
      decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 203, 202, 202),
          label: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: AppStyles.logoColor,
                fontSize: 25,
                fontWeight: FontWeight.w900),
          ),
          suffixIcon: icn),
      controller: ctrl,
    );
  }
}
