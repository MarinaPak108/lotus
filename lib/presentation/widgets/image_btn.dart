import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class MyImageBtn extends StatelessWidget {
  final String link;
  final int idx;
  final Widget page;
  final String label;

  const MyImageBtn(
      {Key? key,
      required this.link,
      required this.label,
      required this.idx,
      required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = global.globalHeight;
    double width = global.globalWidth;
    return Material(
      color: AppStyles.logoColor,
      elevation: height * 0.1,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: AppStyles.rippleColor,
        onTap: () {
          global.navBottmBarIndex = idx;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Column(
          children: [
            Ink.image(
              image: AssetImage(
                link,
              ),
              height: height * 5,
              width: width * 2.5,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Text(
              textAlign: TextAlign.center,
              label,
              style: TextStyle(fontSize: AppStyles.title1, color: Colors.white),
            ),
            SizedBox(
              height: height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
