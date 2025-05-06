import 'package:component/text.dart';
import 'package:flutter/material.dart';

class ScheduleList extends StatefulWidget {
  const ScheduleList({
    super.key,
    this.startTime = "07:00",
    this.middleTime = "03:00",
    this.endTime = "02:00",
    this.onTap,
    this.qtyChair = 20,
    this.buttonBackgroundColor = Colors.deepOrange,
    this.assetImage = const AssetImage("images/assets/ic_arrow.png"),
  });

  final String startTime, middleTime, endTime;
  final VoidCallback? onTap;
  final int qtyChair;
  final Color buttonBackgroundColor;
  final AssetImage? assetImage;

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text18(text: widget.startTime, fontWeight: FontWeight.w500),
                // Text("7:00"),
                // Image.asset(widget.assetImage.toString()),
                Image(image: widget.assetImage!),
                Text18(text: widget.middleTime, fontWeight: FontWeight.w500),
                Image(image: widget.assetImage!),
                Text18(text: widget.endTime, fontWeight: FontWeight.w500),
              ],
            ),

            // Chair qty
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text14(text: "ចំនួនកៅអីនៅសល់"),
                      Text14(text: "Luxury Coaster (${widget.qtyChair})"),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text14(
                        text: "${widget.qtyChair} កៅអី",
                        color: Colors.blue,
                      ),
                      Text14(
                        text: "${widget.qtyChair} កៅអី",
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price and Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "10.0 \$ (Company) - ",
                        style: TextStyle(fontSize: 14),
                      ),
                      TextSpan(
                        text: "9.0 \$ ",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      TextSpan(text: "(Net)", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),

                // Button
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                      color: widget.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "កក់សំបុត្រ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
