import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.fontSize = 10,
    this.onSeclectDate,
    this.text = "Date",
    this.height = 60,
    this.width = 160,
    this.allowPastDates = false,
    this.backgroundColor,
    this.selectedDateColor,
    this.assetImage = const AssetImage("images/assets/ic_flag.png"),
    this.showCurrentDateAuto = true,
    this.clearable = true,
  });

  final Function(String formarttDate)? onSeclectDate;
  final String? text;
  final double? width, height;
  final bool allowPastDates;
  final Color? backgroundColor;
  final Color? selectedDateColor;
  final AssetImage? assetImage;
  final double? fontSize;
  final bool showCurrentDateAuto;
  final bool clearable;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectDate;

  @override
  void initState() {
    super.initState();
    if (widget.showCurrentDateAuto) {
      selectDate = DateTime.now();
      _formatAndSendDate(selectDate!);
    }
  }

  Future<void> _selectDate() async {
    final DateTime now = DateTime.now();
    final DateTime currentDate = DateTime(now.year, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectDate ?? DateTime.now(),
      firstDate: widget.allowPastDates ? DateTime(2000) : currentDate,
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.selectedDateColor ?? Colors.black,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: widget.backgroundColor ?? Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectDate = pickedDate;
      });
      _formatAndSendDate(pickedDate);
    }
  }

  void _clearDate() {
    if (!widget.clearable) return;

    setState(() {
      selectDate = null;
    });
    if (widget.onSeclectDate != null) {
      widget.onSeclectDate!("");
    }
  }

  void _formatAndSendDate(DateTime date) {
    final formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    if (widget.onSeclectDate != null) {
      widget.onSeclectDate!(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Image(image: widget.assetImage!, width: 25),
            ),
            Expanded(
              child: Text(
                selectDate != null
                    ? '${selectDate!.year}/${selectDate!.month}/${selectDate!.day}'
                    : "${widget.text}",
                style: TextStyle(fontSize: widget.fontSize),
              ),
            ),
            if (widget.clearable && selectDate != null)
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: _clearDate,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class DatePicker extends StatefulWidget {
//   const DatePicker({
//     super.key,
//     this.fontSize = 10,
//     this.onSeclectDate,
//     this.text = "Date",
//     this.height = 60,
//     this.width = 160,
//     this.allowPastDates = false,
//     this.backgroundColor,
//     this.selectedDateColor,
//     this.assetImage = const AssetImage("images/assets/ic_flag.png"),
//     this.showCurrentDateAuto = true,
//     this.clearable = true,
//     this.initialDate, // Add this new parameter
//   });

//   final Function(String formarttDate)? onSeclectDate;
//   final String? text;
//   final double? width, height;
//   final bool allowPastDates;
//   final Color? backgroundColor;
//   final Color? selectedDateColor;
//   final AssetImage? assetImage;
//   final double? fontSize;
//   final bool showCurrentDateAuto;
//   final bool clearable;
//   final String? initialDate; // New parameter for initial date

//   @override
//   State<DatePicker> createState() => _DatePickerState();
// }

// class _DatePickerState extends State<DatePicker> {
//   DateTime? selectDate;

//   @override
//   void initState() {
//     super.initState();
//     // First check if initialDate is provided
//     if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
//       try {
//         selectDate = DateTime.parse(widget.initialDate!);
//       } catch (e) {
//         // If parsing fails, fall back to default behavior
//         if (widget.showCurrentDateAuto) {
//           selectDate = DateTime.now();
//           _formatAndSendDate(selectDate!);
//         }
//       }
//     } else if (widget.showCurrentDateAuto) {
//       selectDate = DateTime.now();
//       _formatAndSendDate(selectDate!);
//     }
//   }

//   @override
//   void didUpdateWidget(covariant DatePicker oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Update the selected date when initialDate changes
//     if (widget.initialDate != oldWidget.initialDate) {
//       if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
//         try {
//           setState(() {
//             selectDate = DateTime.parse(widget.initialDate!);
//           });
//         } catch (e) {
//           // Handle parsing error if needed
//         }
//       } else if (widget.clearable) {
//         setState(() {
//           selectDate = null;
//         });
//       }
//     }
//   }

//   Future<void> _selectDate() async {
//     final DateTime now = DateTime.now();
//     final DateTime currentDate = DateTime(now.year, now.month, now.day);

//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectDate ?? DateTime.now(),
//       firstDate: widget.allowPastDates ? DateTime(2000) : currentDate,
//       lastDate: DateTime(2100),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: widget.selectedDateColor ?? Colors.black,
//             ),
//             datePickerTheme: DatePickerThemeData(
//               backgroundColor: widget.backgroundColor ?? Colors.white,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectDate = pickedDate;
//       });
//       _formatAndSendDate(pickedDate);
//     }
//   }

//   void _clearDate() {
//     if (!widget.clearable) return;

//     setState(() {
//       selectDate = null;
//     });
//     if (widget.onSeclectDate != null) {
//       widget.onSeclectDate!("");
//     }
//   }

//   void _formatAndSendDate(DateTime date) {
//     final formattedDate =
//         "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

//     if (widget.onSeclectDate != null) {
//       widget.onSeclectDate!(formattedDate);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _selectDate,
//       child: Container(
//         height: widget.height,
//         width: widget.width,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(width: 1, color: Colors.grey.shade400),
//         ),
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 13),
//               child: Image(image: widget.assetImage!, width: 25),
//             ),
//             Expanded(
//               child: Text(
//                 selectDate != null
//                     ? '${selectDate!.year}/${selectDate!.month}/${selectDate!.day}'
//                     : "${widget.text}",
//                 style: TextStyle(fontSize: widget.fontSize),
//               ),
//             ),
//             if (widget.clearable && selectDate != null)
//               IconButton(
//                 icon: const Icon(Icons.close, size: 18),
//                 onPressed: _clearDate,
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }