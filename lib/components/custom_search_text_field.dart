import 'package:flutter/material.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';

class CustomSearchTextField extends StatefulWidget {
  final Function onChange;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? initialValue;
  final Color? fillColor;
  final Icon? icon;
  final TextStyle? textStyle;
  const CustomSearchTextField(
      {super.key,
      required this.onChange,
      this.hintText,
      this.keyboardType,
      this.initialValue,
      this.fillColor,
      this.textStyle,
      this.icon});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
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
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        fillColor: widget.fillColor ?? AppColors.primaryFixed,
        filled: true,
        hintText: widget.hintText,
        prefix: widget.icon,
        hintStyle: widget.textStyle ??
            AppFonts.titleMedium.copyWith(color: AppColors.onPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // borderSide: const BorderSide(color: AppColors.onPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
