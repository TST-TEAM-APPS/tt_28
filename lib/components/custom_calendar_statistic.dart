import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';

class CustomCalendarStatistic extends StatefulWidget {
  final DateTime value;
  final Function(DateTime, DateTime) onChangeWeek; // Вернуть диапазон недели

  const CustomCalendarStatistic({
    super.key,
    required this.value,
    required this.onChangeWeek,
  });

  @override
  State<CustomCalendarStatistic> createState() =>
      _CustomCalendarStatisticState();
}

class _CustomCalendarStatisticState extends State<CustomCalendarStatistic> {
  DateTime? _selectedDay;

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
    firstDayOfWeek: 1, // Неделя начинается с понедельника
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondary,
      ),
      height: 250,
      child: CalendarDatePicker2(
        config: config,
        value: [_selectedDay ?? widget.value], // Подсветка выбранного дня
        onValueChanged: (dates) {
          if (dates.isNotEmpty) {
            final selectedDay = dates[0];
            final startOfWeek =
                selectedDay.subtract(Duration(days: selectedDay.weekday - 1));
            final endOfWeek = startOfWeek.add(const Duration(days: 6));

            setState(() {
              _selectedDay = selectedDay;
            });

            widget.onChangeWeek(startOfWeek, endOfWeek); // Возврат недели
          }
        },
      ),
    );
  }
}
