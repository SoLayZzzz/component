// import 'dart:convert';
// import 'package:flutter/material.dart';

// class SeatLayoutWidget extends StatelessWidget {
//   final String layoutJson;
//   final List<String> occupiedSeats;
//   final List<Map<String, String>> selectedSeats;
//   final Function(String value, String label) onSeatTap;
//   final bool isScanScreen;
//   final int seatType; // 1 = normal, 2 = bed

//   const SeatLayoutWidget({
//     super.key,
//     required this.layoutJson,
//     required this.occupiedSeats,
//     required this.selectedSeats,
//     required this.onSeatTap,
//     this.isScanScreen = false,
//     this.seatType = 1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     try {
//       final layoutData = jsonDecode(layoutJson) as List<dynamic>;

//       // ✅ Calculate max columns
//       int maxColumns = 0;
//       for (var row in layoutData) {
//         final columns = (row as Map<String, dynamic>)['col'] as List<dynamic>;
//         int columnCount = 0;
//         for (var col in columns) {
//           final attr = col['attr'] as Map<String, dynamic>;
//           final colspan = int.tryParse(attr['colspan']?.toString() ?? '1') ?? 1;
//           columnCount += colspan;
//         }
//         if (columnCount > maxColumns) {
//           maxColumns = columnCount;
//         }
//       }

//       return ListView.builder(
//         itemCount: layoutData.length,
//         itemBuilder: (context, rowIndex) {
//           final row = layoutData[rowIndex] as Map<String, dynamic>;
//           final columns = row['col'] as List<dynamic>;

//           int totalColspan = 0;
//           for (var col in columns) {
//             final attr = col['attr'] as Map<String, dynamic>;
//             totalColspan +=
//                 int.tryParse(attr['colspan']?.toString() ?? '1') ?? 1;
//           }
//           int remainingSpace = maxColumns - totalColspan;

//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4.0),
//             child: Row(
//               children: [
//                 if (remainingSpace > 0)
//                   Expanded(flex: remainingSpace ~/ 2, child: const SizedBox()),
//                 ...columns.map((colData) {
//                   return _buildSeatItem(
//                     context,
//                     colData as Map<String, dynamic>,
//                     maxColumns,
//                   );
//                 }),
//                 if (remainingSpace > 0)
//                   Expanded(
//                     flex: (remainingSpace ~/ 2) + (remainingSpace % 2),
//                     child: const SizedBox(),
//                   ),
//               ],
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       return Center(child: Text("Error: $e"));
//     }
//   }

//   Widget _buildSeatItem(
//     BuildContext context,
//     Map<String, dynamic> seatData,
//     int maxColumns,
//   ) {
//     final attr = seatData['attr'] as Map<String, dynamic>;
//     final label = seatData['label']?.toString() ?? '';
//     final value = seatData['value']?.toString() ?? '';
//     final colspan = int.tryParse(attr['colspan']?.toString() ?? '1') ?? 1;

//     if (label.isEmpty && value.isEmpty) {
//       return Expanded(flex: colspan, child: const SizedBox());
//     }

//     // ✅ Special cases
//     if (label == "Door" || label == "Toilet") {
//       return Expanded(
//         flex: colspan,
//         child: Container(
//           margin: const EdgeInsets.all(4),
//           child: Center(
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       );
//     }

//     if (label == "Down Stair" || label == "Up Stair") {
//       return Expanded(
//         flex: colspan,
//         child: Container(
//           height: 30,
//           decoration: BoxDecoration(
//             color: Colors.orange[100],
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Center(child: Text(label)),
//         ),
//       );
//     }

//     bool isOccupied = occupiedSeats.any(
//       (s) => s.trim().toLowerCase() == value.trim().toLowerCase(),
//     );
//     bool isSelected = selectedSeats.any(
//       (s) => s['value']?.trim().toLowerCase() == value.trim().toLowerCase(),
//     );

//     String seatImage;
//     if (label == "Capitain") {
//       seatImage = AppIcons.IC_Driver;
//       isOccupied = true;
//     } else if (label == "Hostess") {
//       seatImage = AppIcons.IC_Hotess;
//       isOccupied = true;
//     } else if (isOccupied) {
//       seatImage =
//           seatType == 2
//               ? AppIcons.IC_seat_Bed_not_free
//               : AppIcons.IC_seat_not_free;
//     } else if (isSelected) {
//       seatImage =
//           seatType == 2 ? AppIcons.IC_seat_Bed_select : AppIcons.IC_seat_select;
//     } else {
//       seatImage =
//           seatType == 2 ? AppIcons.IC_seat_Bed_free : AppIcons.IC_seat_free;
//     }

//     return Expanded(
//       flex: colspan,
//       child: GestureDetector(
//         onTap:
//             value.isEmpty || isOccupied ? null : () => onSeatTap(value, label),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(seatImage, height: 45, width: 45),
//             if (label.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: Text1(text: label, color: Colors.black),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
