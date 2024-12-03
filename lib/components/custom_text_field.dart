import 'package:flutter/material.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';

class CustomTextField extends StatefulWidget {
  final Function onChange;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? initialValue;
  final Color? fillColor;
  final Icon? icon;
  final TextStyle? textStyle;
  const CustomTextField(
      {super.key,
      required this.onChange,
      this.hintText,
      this.keyboardType,
      this.initialValue,
      this.fillColor,
      this.textStyle,
      this.icon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    if (widget.initialValue != null) {
      _textEditingController.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: _textEditingController,
      keyboardType: widget.keyboardType,
      style: AppFonts.titleMedium.copyWith(color: AppColors.onPrimary),
      cursorColor: AppColors.onPrimary,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      onChanged: (value) {
        widget.onChange(value);
      },
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        fillColor: widget.fillColor ?? AppColors.primaryFixed,
        filled: true,
        hintText: widget.hintText,
        prefixIcon: widget.icon,
        hintStyle: widget.textStyle ??
            AppFonts.titleMedium
                .copyWith(color: AppColors.onPrimary.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.surface),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.surface),
        ),
      ),
    );
  }
}
