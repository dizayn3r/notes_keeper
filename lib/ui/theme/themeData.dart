import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/text_styles.dart';

//DE2040
const bgColorDark = Color(0xFF201a1a);
const bgColorLight = Color(0xFFfffbff);
const accentLight = Color(0xffbf0030);
const accentDark =  Color(0xFFffb3b3);
const borderColor =  Color(0xffd3d3d3);
const foregroundColor =  Color(0xff595959);

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgColorLight,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      color: bgColorLight,
      iconTheme: const IconThemeData(color: Color(0xFF202020)),
      titleTextStyle: titleTextStyle.copyWith(color: const Color(0xFF202020)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentLight,
      foregroundColor: bgColorLight,
      extendedTextStyle: GoogleFonts.quicksand(
        fontWeight:FontWeight.bold,
        color: bgColorLight,
        fontSize: 18,
      ),
    ),
    textTheme: TextTheme(
      headline5: GoogleFonts.quicksand(
        fontWeight:FontWeight.bold,
        color: const Color(0xFF202020),
        fontSize: 24,
      ),
      bodyText2: GoogleFonts.quicksand(
        fontWeight:FontWeight.bold,
        color:const Color(0xFF202020),
        fontSize: 20,
      ),
      bodyText1: GoogleFonts.quicksand(
        fontWeight:FontWeight.normal,
        color:const Color(0xFF202020),
        fontSize: 18,
      ),
      subtitle2: GoogleFonts.quicksand(
        fontWeight:FontWeight.normal,
        color:const Color(0xFF202020),
        fontSize: 14,
      ),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColorDark,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      color: bgColorDark,
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      titleTextStyle: titleTextStyle.copyWith(color: const Color(0xFFFFFFFF)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentDark,
      foregroundColor: bgColorDark,
      extendedTextStyle: GoogleFonts.quicksand(
        fontWeight:FontWeight.bold,
        color: bgColorDark,
        fontSize: 18,
      ),
    ),
    textTheme: TextTheme(
      headline5: GoogleFonts.quicksand(
        fontWeight:FontWeight.bold,
        color: const Color(0xFF202020),
        fontSize: 24,
      ),
      bodyText2: GoogleFonts.quicksand(
        fontWeight:FontWeight.bold,
        color:const Color(0xFF202020),
        fontSize: 20,
      ),
      bodyText1: GoogleFonts.quicksand(
        fontWeight:FontWeight.normal,
        color:const Color(0xFF202020),
        fontSize: 18,
      ),
      subtitle2: GoogleFonts.quicksand(
        fontWeight:FontWeight.normal,
        color:const Color(0xFF202020),
        fontSize: 14,
      ),
    ),
  );

}
