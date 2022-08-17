import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PriorityPicker extends StatefulWidget {
  int index;
  Function(int) onTap;
  PriorityPicker({Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  _PriorityPickerState createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  List<String> nameList = ['Low', 'High', 'Very High'];
  List<Color> colorList = [Colors.green, Colors.orange, Colors.red];
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double w = (sizingInformation.screenSize.width / 100).roundToDouble();

        Widget priorityContainer(int index, BuildContext context) {
          return Expanded(
            child: InkWell(
              onTap: () {
                widget.index = index;
                widget.onTap(index);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w),
                    border: Border.all(color: Colors.black),
                    color: widget.index == index
                        ? colorList[index]
                        : Colors.white),
                child: Text(
                  nameList[index],
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color:
                          widget.index == index ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        }

        return SizedBox(
          width: w * 100,
          height: w * 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              priorityContainer(0, context),
              SizedBox(width: w * 2),
              priorityContainer(1, context),
              SizedBox(width: w * 2),
              priorityContainer(2, context),
            ],
          ),
        );
      },
    );
  }
}
