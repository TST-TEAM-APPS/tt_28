import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:forest_tinker_live/core/app_fonts.dart';
import 'package:forest_tinker_live/core/colors.dart';

class CustomCalendar extends StatefulWidget {
  final List<DateTime?> value;
  final Function onChangeDate;
  const CustomCalendar(
      {super.key, required this.value, required this.onChangeDate});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final config = CalendarDatePicker2Config(
    selectedDayHighlightColor: AppColors.primary,
    disableMonthPicker: true,
    disableModePicker: true,
    lastMonthIcon: const Icon(
      Icons.arrow_back_ios,
      color: Colors.white,
    ),
    nextMonthIcon: const Icon(
      Icons.arrow_forward_ios,
      color: Colors.white,
    ),
    weekdayLabels: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
    weekdayLabelTextStyle:
        AppFonts.titleSmall.copyWith(color: AppColors.onPrimary),
    firstDayOfWeek: 1,
    controlsHeight: 50,
    dayMaxWidth: 25,
    controlsTextStyle:
        AppFonts.titleMedium.copyWith(color: AppColors.onPrimary),
    dayTextStyle: AppFonts.titleMedium.copyWith(color: AppColors.onPrimary),
    disabledDayTextStyle: const TextStyle(
      color: Colors.white,
    ),
    centerAlignModePicker: true,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondary,
      ),
      height: 250,
      child: CalendarDatePicker2(
        config: config,
        value: widget.value,
        onValueChanged: (dates) {
          widget.onChangeDate(dates[0]);
        },
      ),
    );
  }
}
