import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

class MyCard extends StatelessWidget {
  final Widget fillWith;

  const MyCard({Key? key, required this.fillWith}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height / 10;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height * 0.4)),
      color: AppStyles.logoComplimentaryColor2,
      elevation: height * 0.1,
      //color: const Color.fromARGB(242, 132, 244, 237),
      shadowColor: const Color.fromARGB(227, 87, 70, 131),
      child: Padding(
        padding: EdgeInsets.all(height * 0.2),
        child: Container(
            decoration: const BoxDecoration(
              backgroundBlendMode: BlendMode.color,
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(227, 87, 70, 131),
                  AppStyles.backgroundLogoColor,
                  Color.fromARGB(227, 87, 70, 131),
                ],
              ),
            ),
            child: fillWith),
      ),
    );
  }
}
