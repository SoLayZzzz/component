import 'package:component/text.dart';
import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, this.onSeclectDate, this.text = "Date"});

  final Function(String formarttDate)? onSeclectDate;
  final String? text;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime? selectDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectDate = pickedDate;
      });

      // yyyy/mm/dd
      final formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

      // dd/mm/yyyy
      // final formattedDate =
      //     "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString().substring(2)}";

      if (widget.onSeclectDate != null) {
        widget.onSeclectDate!(formattedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final day = ;
    return GestureDetector(
      onTap: () {
        _selectDate();
      },
      child: Container(
        height: 55,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.calendar_month, color: Colors.black.withAlpha(190)),
            Text16(
              text:
                  selectDate != null
                      ? '${selectDate!.year}/${selectDate!.month}/${selectDate!.day}'
                      : "${widget.text}",
              color: Colors.black.withAlpha(170),
            ),
          ],
        ),
      ),
    );
  }
}
