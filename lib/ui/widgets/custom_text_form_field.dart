import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String errorText;
  final int minLines;
  final int maxLines;

  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.errorText,required this.minLines,required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double w = (sizingInformation.screenSize.width / 100).roundToDouble();
        return TextFormField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            label: Text(labelText),
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 2),
              borderSide: BorderSide(color: Colors.grey.shade50),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: w * 4, vertical: w),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorText;
            }
            return controller.text = value.trim();
          },
          onSaved: (value) {
            controller.text = value!.trim();
          },
        );
      },
    );
  }
}
