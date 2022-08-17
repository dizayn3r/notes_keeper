import 'package:flutter/material.dart';

const bgColorDark = Color(0xFF201a1a);
const bgColorLight = Color(0xFFfffbff);
const accentLight = Color(0xffbf0030);
const accentDark =  Color(0xFFffb3b3);
const borderColor =  Color(0xffd3d3d3);
const foregroundColor =  Color(0xff595959);

const tileColors = [
  Color(0xFFffab91),
  Color(0xFFffcc80),
  Color(0xFFe6ee9b),
  Color(0xFF80deea),
  Color(0xFFcf93d9),
  Color(0xFF80cbc4),
  Color(0xFFf48fb1),
];

class Tile{
  color(int index) {
    final c1Light = [
      const Color(0xFFffab91),
      const Color(0xFFffcc80),
      const Color(0xFFe6ee9b),
      const Color(0xFF80deea),
      const Color(0xFFcf93d9),
      const Color(0xFF80cbc4),
      const Color(0xFFf48fb1),
    ];
    return c1Light[index % c1Light.length];
  }
}