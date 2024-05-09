import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

class MyInputField extends StatelessWidget {
  final String label;
  final TextEditingController? ctrl;
  final bool isPwdVisible;
  final IconButton? icn;

  const MyInputField(
      {Key? key,
      required this.label,
      this.ctrl,
      this.isPwdVisible = false,
      this.icn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPwdVisible,
      style:
          const TextStyle(color: Color.fromARGB(255, 47, 47, 47), fontSize: 25),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 105, 105, 105), width: 3),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.logoColor, width: 3)),
          label: Text(
            label,
            style: const TextStyle(color: AppStyles.logoColor, fontSize: 25),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          suffixIcon: icn),
      controller: ctrl,
    );
  }
}
