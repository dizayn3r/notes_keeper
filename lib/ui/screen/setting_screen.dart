import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../theme/config.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDark = currentTheme.currentTheme() == ThemeMode.light ? false : true;

  toggle(bool value) {
    currentTheme.switchTheme();
    if (isDark == false) {
      setState(() {
        isDark = true;
      });
    } else {
      setState(() {
        isDark = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double w = (sizingInformation.screenSize.width / 100).roundToDouble();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left_outlined,
              ),
            ),
            title: Text(
              'Settings',
              style: titleTextStyle,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(w * 2),
            child: Column(
              children: [
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 2),
                  ),
                  child: SwitchListTile(
                    activeColor: accentDark,
                    title: Text(
                      'Theme',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: isDark ? bgColorLight : bgColorDark,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      isDark ? 'Dark' : 'Light',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: isDark ? accentDark : accentLight,
                        fontSize: 18,
                      ),
                    ),
                    value: isDark,
                    onChanged: toggle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
