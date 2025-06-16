import 'package:component/text.dart';
import 'package:flutter/material.dart';

class TextComboBox extends StatefulWidget {
  TextComboBox({
    super.key,
    this.showIcon = true,
    this.listData = const ['Apple', 'Banana', 'Orange'],
    required this.onValueChanged,
    this.assetImage = const AssetImage("images/assets/ic_flag.png"),
    this.height = 50,
  });

  final bool showIcon;
  final List<dynamic> listData;
  final Function(String) onValueChanged;
  final AssetImage? assetImage;
  final double height;

  @override
  State<TextComboBox> createState() => _TextComboBoxState();
}

class _TextComboBoxState extends State<TextComboBox> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.grey.shade400),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                if (widget.showIcon) ...[
                  Image(image: widget.assetImage!, width: 25),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: selectedValue,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                          if (newValue != null) {
                            widget.onValueChanged(newValue);
                          }
                        },
                        items:
                            widget.listData.map((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text14(
                                  text: value.toString(),
                                  color: Colors.grey.shade700,
                                ),
                              );
                            }).toList(),
                        hint: Text14(
                          text: "ជ្រើសរើស",
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
