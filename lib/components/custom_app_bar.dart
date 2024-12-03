import 'package:flutter/material.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final Widget? rightWidget;
  const CustomAppBar({super.key, required this.title, this.rightWidget});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: AppColors.onPrimary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 24,
              width: 24,
              color: Colors.transparent,
              child: const Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ),
        Text(
          widget.title,
          style: AppFonts.headlineMedium.copyWith(
            color: AppColors.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        widget.rightWidget != null
            ? SizedBox(width: 24, child: widget.rightWidget!)
            : const SizedBox(
                width: 24,
              )
      ],
    );
  }
}
