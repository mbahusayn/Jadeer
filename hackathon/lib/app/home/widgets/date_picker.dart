import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/utils/functions.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/style/colors.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime currentDate = DateTime.now();
  String selectedDate = "";

  @override
  void initState() {
    selectedDate =
        "${monthText(currentDate.month)} ${currentDate.day}, ${currentDate.year}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              height: getHeight(context) * 0.27,
              width: getWidth(context),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (isExpenseue) {
                  setState(() {
                    selectedDate =
                        "${monthText(isExpenseue.month)} ${isExpenseue.day}, ${isExpenseue.year}";
                  });
                },
              ),
            );
          },
        );
      },
      child: Container(
        width: getWidth(context) * 0.6,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          const Icon(
            Icons.watch_later_outlined,
            color: ColorsApp.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              selectedDate,
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.grey,
          )
        ]),
      ),
    );
  }
}
