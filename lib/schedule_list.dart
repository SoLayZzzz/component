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
    this.price,
    this.agencyPrice,
    this.buttonText = "កក់សំបុត្រ", // New parameter
    this.isButtonEnabled = true, // New parameter
  });

  final String startTime, middleTime, endTime;
  final VoidCallback? onTap;
  final int qtyChair;
  final Color buttonBackgroundColor;
  final AssetImage? assetImage;
  final double? price;
  final double? agencyPrice;
  final String buttonText; // New parameter
  final bool isButtonEnabled; // New parameter

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
                        text: "${widget.price} \$ (Company) - ",
                        style: TextStyle(fontSize: 14),
                      ),
                      TextSpan(
                        text: "${widget.agencyPrice} \$ ",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      TextSpan(text: "(Net)", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),

                // Updated Button with disabled state
                Opacity(
                  opacity: widget.isButtonEnabled ? 1.0 : 0.6,
                  child: Material(
                    color:
                        widget.isButtonEnabled
                            ? widget.buttonBackgroundColor
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: widget.isButtonEnabled ? widget.onTap : null,
                      child: Container(
                        height: 35,
                        width: 120,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Center(
                          child: Text(
                            widget.buttonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
