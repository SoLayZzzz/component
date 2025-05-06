import 'package:component/text.dart';
import 'package:flutter/material.dart';

class TextComboBox extends StatefulWidget {
  TextComboBox({
    super.key,
    this.showIcon = true,
    this.listData = const ['Apple', 'Banana', 'Orange'],
    // this.selectedValue,
    required this.onValueChanged,
  });

  final bool showIcon;
  final List<dynamic> listData;

  final Function(String) onValueChanged;

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
          height: 60,
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
                  Image.asset("images/assets/ic_flag.png", width: 25),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
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
                              value: value,
                              child: Row(
                                children: [
                                  Text14(
                                    text: value,
                                    color: Colors.grey.shade700,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                      hint: Text14(text: "Choose", color: Colors.grey.shade700),
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
