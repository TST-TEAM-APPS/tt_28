import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_28/components/custom_calendar.dart';
import 'package:tt_28/core/app_fonts.dart';
import 'package:tt_28/core/colors.dart';

class CurrentDateWIdget extends StatefulWidget {
  final Function onChangeDate;
  final List<DateTime> value;
  const CurrentDateWIdget(
      {super.key, required this.onChangeDate, required this.value});

  @override
  State<CurrentDateWIdget> createState() => _CurrentDateWIdgetState();
}

class _CurrentDateWIdgetState extends State<CurrentDateWIdget> {
  void _showBottomSheet(BuildContext context, Function? onChange) {
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
                    child: CustomCalendar(
                      value: widget.value,
                      onChangeDate: (DateTime value) async {
                        await widget.onChangeDate(value);
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
    String formattedDate = DateFormat('dd.MM.yyyy').format(widget.value[0]);

    return Container(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          _showBottomSheet(context, widget.onChangeDate);
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
                    formattedDate,
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
