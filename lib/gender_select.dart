import 'package:flutter/material.dart';

class GenderSelectOption extends StatefulWidget {
  const GenderSelectOption({
    super.key,
    this.onTap,
    this.selected = false,
    required this.icon,
    required this.label,
    this.selectColor = const Color(0xFF2C3E50),
    this.unselectColor = Colors.white,
    this.selectTextColor = Colors.white,
    this.unselectTextColor = Colors.black87,
    this.borderColor = Colors.black26,
    this.borderWidth = 1.5,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.iconSize = 14,
    this.fontSize = 14,
  });

  final VoidCallback? onTap;
  final bool selected;
  final IconData icon;
  final String label;
  final Color selectColor;
  final Color unselectColor;
  final Color selectTextColor;
  final Color unselectTextColor;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;
  final double iconSize;
  final double fontSize;

  @override
  State<GenderSelectOption> createState() => _GenderSelectOptionState();
}

class _GenderSelectOptionState extends State<GenderSelectOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.selected ? widget.selectColor : widget.unselectColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.selected ? Colors.transparent : widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color:
                  widget.selected
                      ? widget.selectTextColor
                      : widget.unselectTextColor,
              size: widget.iconSize,
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                color:
                    widget.selected
                        ? widget.selectTextColor
                        : widget.unselectTextColor,
                fontSize: widget.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
