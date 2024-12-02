import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_28/components/custom_calendar_statistic.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';

class CurrentDateWIdgetStatistic extends StatefulWidget {
  final Function(DateTime, DateTime) onChangeWeek;
  final DateTime value;

  const CurrentDateWIdgetStatistic({
    super.key,
    required this.onChangeWeek,
    required this.value,
  });

  @override
  State<CurrentDateWIdgetStatistic> createState() =>
      _CurrentDateWIdgetStatisticState();
}

class _CurrentDateWIdgetStatisticState
    extends State<CurrentDateWIdgetStatistic> {
  late DateTime _startOfWeek;
  late DateTime _endOfWeek;

  @override
  void initState() {
    super.initState();
    _calculateWeek(widget.value);
  }

  void _calculateWeek(DateTime date) {
    setState(() {
      _startOfWeek = date.subtract(Duration(days: date.weekday - 1));
      _endOfWeek = _startOfWeek.add(const Duration(days: 6));
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: AppColors.onPrimary,
                        )),
                    child: CustomCalendarStatistic(
                      value: widget.value,
                      onChangeWeek: (DateTime start, DateTime end) {
                        _calculateWeek(start);
                        widget.onChangeWeek(start, end);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String formattedWeek =
        '${DateFormat('dd.MM.yyyy').format(_startOfWeek)} - ${DateFormat('dd.MM.yyyy').format(_endOfWeek)}';

    return Container(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          _showBottomSheet(context);
        },
        highlightColor: Colors.white.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.arrow_back_ios,
                size: 21,
                color: Colors.white,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/calendar.png',
                    height: 21,
                    width: 21,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    formattedWeek,
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 21,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
