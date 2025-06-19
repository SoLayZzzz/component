// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class SelectNationality extends StatefulWidget {
//   SelectNationality({
//     super.key,
//     this.borderRadius,
//     this.nationalityList = const [],
//     this.backgroundColor,
//     this.borderColor = Colors.grey,
//     this.borderWidth = 1,
//     this.assetImage = const AssetImage("images/assets/ic_flag.png"),
//     this.text,
//     this.showChooseScreen = false,
//     this.onTap,
//     this.onSelected,
//     this.noDataIcon = Icons.close_outlined,
//     this.noDataText,
//     this.textStyle,
//     this.isLoading = false,
//     this.isEnabled = true,
//     this.hintText,
//     this.titleTextField,
//     this.title,
//     this.hasError = false,
//     this.errorText,
//     this.suffixIcon,
//     this.appBar,
//     this.height,
//   });

//   final AppBar? appBar;
//   final bool showChooseScreen;
//   final BorderRadius? borderRadius;
//   final List<dynamic> nationalityList;
//   final Color? backgroundColor;
//   final Color? borderColor;
//   final double borderWidth;
//   final AssetImage? assetImage;
//   String? text;
//   final VoidCallback? onTap;
//   final ValueChanged<int>? onSelected;
//   final String? noDataText;
//   final IconData? noDataIcon;
//   final TextStyle? textStyle;
//   final bool isLoading;
//   final bool isEnabled;
//   final String? hintText;
//   final String? titleTextField;
//   final String? title;
//   final bool hasError;
//   final String? errorText;
//   final String? suffixIcon;
//   final double? height;

//   @override
//   State<SelectNationality> createState() => _SelectNationalityState();
// }

// class _SelectNationalityState extends State<SelectNationality> {
//   late String? selectedText;

//   @override
//   void initState() {
//     super.initState();
//     selectedText = widget.text;
//   }

//   void _navigateAndSelect() async {
//     if (!widget.isEnabled || widget.isLoading) return;

//     if (widget.showChooseScreen) {
//       if (widget.nationalityList.isEmpty) return;

//       final result = await Navigator.push<Map<String, dynamic>>(
//         context,
//         MaterialPageRoute(
//           builder:
//               (_) => ChooseScreen(
//                 appBar: widget.appBar,
//                 nationalityList: widget.nationalityList,
//                 selectNationality: selectedText,
//                 hintText: widget.hintText ?? widget.text,
//                 noDataIcon: widget.noDataIcon,
//                 noDataText: widget.noDataText,
//                 title: widget.titleTextField,
//                 suffixIcon: widget.suffixIcon,
//               ),
//         ),
//       );

//       if (result != null && mounted) {
//         setState(() {
//           selectedText = result["value"];
//           widget.text = selectedText;
//         });
//         widget.onSelected?.call(result["index"]);
//       }
//     } else {
//       widget.onTap?.call();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final effectiveTextStyle =
//         widget.textStyle ??
//         TextStyle(
//           color: widget.isEnabled ? Colors.black : Colors.grey,
//           fontSize: 16,
//         );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: _navigateAndSelect,
//           child: Container(
//             height: widget.height,
//             decoration: BoxDecoration(
//               color: widget.backgroundColor,
//               borderRadius: widget.borderRadius,
//               border: Border.all(
//                 width: widget.borderWidth,
//                 color: widget.hasError ? Colors.red : widget.borderColor!,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 18, bottom: 18),
//               child: Center(
//                 child: Row(
//                   children: [
//                     if (widget.assetImage != null)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 13),
//                         child: Image(
//                           image: widget.assetImage!,
//                           width: 24,
//                           color: widget.isEnabled ? null : Colors.grey,
//                         ),
//                       ),
//                     Expanded(
//                       child:
//                           widget.isLoading
//                               ? const Padding(
//                                 padding: EdgeInsets.only(right: 20),
//                                 child: SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                   ),
//                                 ),
//                               )
//                               : Text(
//                                 selectedText ??
//                                     widget.hintText ??
//                                     widget.title.toString(),
//                                 style: effectiveTextStyle.copyWith(
//                                   color: Color(0xFF545454),
//                                   // color:
//                                   //     widget.isEnabled ? null : Color(0xFF545454),
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                     ),
//                     Icon(Icons.arrow_drop_down, color: Colors.grey, size: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (widget.hasError && widget.errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 4.0, left: 12.0),
//             child: Text(
//               widget.errorText!,
//               style: const TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class ChooseScreen extends StatefulWidget {
//   const ChooseScreen({
//     super.key,
//     required this.nationalityList,
//     this.hintText,
//     this.selectNationality,
//     this.noDataIcon,
//     this.noDataText,
//     this.title,
//     this.suffixIcon,
//     this.appBar,
//   });

//   final List<dynamic> nationalityList;
//   final String? hintText;
//   final String? selectNationality;
//   final String? noDataText;
//   final IconData? noDataIcon;
//   final String? title;
//   final String? suffixIcon;
//   final AppBar? appBar;

//   @override
//   State<ChooseScreen> createState() => _ChooseScreenState();
// }

// class _ChooseScreenState extends State<ChooseScreen> {
//   List<dynamic> filteredData = [];
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     filteredData = widget.nationalityList;
//     if (widget.selectNationality != null) {
//       _controller.text = widget.selectNationality!;
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _filterData(String query) {
//     setState(() {
//       filteredData =
//           widget.nationalityList
//               .where(
//                 (item) =>
//                     item.toString().toLowerCase().contains(query.toLowerCase()),
//               )
//               .toList();
//     });
//   }

//   void _selectItem(String value) {
//     final index = widget.nationalityList.indexOf(value);
//     Navigator.pop(context, {"value": value, "index": index});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: widget.appBar,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//               child: SizedBox(
//                 height: 50,
//                 child: TextField(
//                   onChanged: _filterData,
//                   controller: _controller,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: widget.hintText ?? widget.title,
//                     suffixIcon: Padding(
//                       padding: const EdgeInsets.all(13),
//                       child: Image.asset(
//                         widget.suffixIcon.toString(),
//                         width: 5,
//                       ),
//                     ),
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 1,
//                         color: Colors.grey,
//                       ),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                   ),
//                 ),
//               ),
//             ),
//             // =====
//             Expanded(
//               child:
//                   filteredData.isEmpty
//                       ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               widget.noDataIcon,
//                               size: 50,
//                               color: Colors.grey,
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               widget.noDataText ?? 'No data found',
//                               style: const TextStyle(color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                       )
//                       : ListView.builder(
//                         itemCount: filteredData.length,
//                         itemBuilder: (context, index) {
//                           final value = filteredData[index];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: InkWell(
//                               onTap: () => _selectItem(value.toString()),
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: const Border(
//                                     bottom: BorderSide(
//                                       width: 1,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   color:
//                                       value.toString() ==
//                                               widget.selectNationality
//                                           ? Colors.grey[200]
//                                           : Colors.transparent,
//                                 ),
//                                 child: Text(value.toString()),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectNationality extends StatefulWidget {
  SelectNationality({
    super.key,
    this.borderRadius,
    this.nationalityList = const [],
    this.backgroundColor,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
    this.assetImage = const AssetImage("images/assets/ic_flag.png"),
    this.text,
    this.showChooseScreen = false,
    this.onTap,
    this.onSelected,
    this.noDataIcon = Icons.close_outlined,
    this.noDataText,
    this.textStyle,
    this.isLoading = false,
    this.isEnabled = true,
    this.hintText,
    this.titleTextField,
    this.title,
    this.hasError = false,
    this.errorText,
    this.suffixIcon,
    this.appBar,
    this.height,
  });

  final AppBar? appBar;
  final bool showChooseScreen;
  final BorderRadius? borderRadius;
  final List<dynamic> nationalityList;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final AssetImage? assetImage;
  String? text;
  final VoidCallback? onTap;
  final ValueChanged<int>? onSelected;
  final String? noDataText;
  final IconData? noDataIcon;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isEnabled;
  final String? hintText;
  final String? titleTextField;
  final String? title;
  final bool hasError;
  final String? errorText;
  final String? suffixIcon;
  final double? height;

  @override
  State<SelectNationality> createState() => _SelectNationalityState();
}

class _SelectNationalityState extends State<SelectNationality> {
  late String? selectedText;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> filteredData = [];

  @override
  void initState() {
    super.initState();
    selectedText = widget.text;
    filteredData = widget.nationalityList;
    _searchController.addListener(_filterData);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterData() {
    setState(() {
      filteredData =
          widget.nationalityList
              .where(
                (item) => item.toString().toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  Future<void> _showNationalityDialog() async {
    if (!widget.isEnabled ||
        widget.isLoading ||
        widget.nationalityList.isEmpty) {
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              if (widget.appBar != null) widget.appBar!,
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: widget.hintText ?? widget.title,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Image.asset(
                        widget.suffixIcon.toString(),
                        width: 5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              Expanded(
                child:
                    filteredData.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget.noDataIcon,
                                size: 50,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.noDataText ?? 'No data found',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            final value = filteredData[index];
                            return ListTile(
                              title: Text(value.toString()),
                              onTap: () {
                                Navigator.pop(context, {
                                  "value": value.toString(),
                                  "index": widget.nationalityList.indexOf(
                                    value,
                                  ),
                                });
                              },
                            );
                          },
                        ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null && mounted) {
      setState(() {
        selectedText = result["value"];
        widget.text = selectedText;
      });
      widget.onSelected?.call(result["index"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle =
        widget.textStyle ??
        TextStyle(
          color: widget.isEnabled ? Colors.black : Colors.grey,
          fontSize: 16,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:
              widget.showChooseScreen ? _showNationalityDialog : widget.onTap,
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: widget.borderRadius,
              border: Border.all(
                width: widget.borderWidth,
                color: widget.hasError ? Colors.red : widget.borderColor!,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: Center(
                child: Row(
                  children: [
                    if (widget.assetImage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Image(
                          image: widget.assetImage!,
                          width: 24,
                          color: widget.isEnabled ? null : Colors.grey,
                        ),
                      ),
                    Expanded(
                      child:
                          widget.isLoading
                              ? const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                              : Text(
                                selectedText ??
                                    widget.hintText ??
                                    widget.title.toString(),
                                style: effectiveTextStyle.copyWith(
                                  color: Color(0xFF545454),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey, size: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.hasError && widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
