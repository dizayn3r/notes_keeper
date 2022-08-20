import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<Color> colors = [
  Color(0xffF28B83),
  Color(0xFFFCBC05),
  Color(0xFFFFF476),
  Color(0xFFCBFF90),
  Color(0xFFA7FEEA),
  Color(0xFFE6C9A9),
  Color(0xFFE8EAEE),
  Color(0xFFA7FEEA),
  Color(0xFFCAF0F8),
];

class ColorPicker extends StatefulWidget {
  int index;
  final Function(int) onTap;
  ColorPicker({Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double w = (sizingInformation.screenSize.width / 100).roundToDouble();

        Widget colorContainer(int index, double w) {
          return InkWell(
            onTap: () {
              widget.index = index;
              widget.onTap(index);
              setState(() {});
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: w * 7,
                  height: w * 7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 4),
                      border:
                          Border.all(color: Colors.grey.shade900, width: 1.5),
                      color: colors[index]),
                ),
                widget.index == index
                    ? Icon(Icons.check_rounded,
                        color: Colors.grey.shade900, size: w * 5)
                    : Container()
              ],
            ),
          );
        }

        return SizedBox(
          height: w * 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              colorContainer(0, w),
              colorContainer(1, w),
              colorContainer(2, w),
              colorContainer(3, w),
              colorContainer(4, w),
              colorContainer(5, w),
              colorContainer(6, w),
              colorContainer(7, w),
              colorContainer(8, w),
            ],
          ),
        );
      },
    );
  }
}
