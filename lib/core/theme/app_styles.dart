import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class AppStyles {
  static const activeMainC = Color.fromARGB(255, 44, 179, 48);
  static const activeLightC = Colors.green;
  static const notActiveC = Color.fromRGBO(105, 105, 105, 1);
  static const notActiveDarkC = Color.fromARGB(255, 47, 47, 47);
  static const logoColor = Color.fromRGBO(86, 181, 175, 1);
  static const backgroundLogoColorDark = Color.fromRGBO(132, 220, 214, 0.533);
  static const logoComplimentaryColor = Color.fromRGBO(179, 102, 103, 1);
  static const logoComplimentaryColor2 = Color.fromRGBO(52, 36, 91, 0.898);
  static const rippleColor = Color.fromRGBO(86, 181, 175, 0.3);
  static const borderLogoColor = Colors.white;
  static const backgroundLogoColor = Color.fromARGB(255, 112, 229, 221);

  static const labelFontSize = 25;
  static const inputInfoFontSize = 28;

  double height = global.globalHeight;
  double width = global.globalWidth;

  static double title1 = global.globalHeight * 0.4;
  static double text = global.globalHeight * 0.3;

  static const borderActive =
      OutlineInputBorder(borderSide: BorderSide(color: activeMainC, width: 3));
  static const borderNonActive =
      OutlineInputBorder(borderSide: BorderSide(color: notActiveC, width: 3));
  static final title = GoogleFonts.lato(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.green,
  );

  static final body = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 122, 188, 125),
  );

  static final date = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(255, 105, 105, 105),
  );

  static final noteTitle = GoogleFonts.lato(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 178, 184, 178),
  );
}
