import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                label,
                style: GoogleFonts.lobster(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
