import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectLocation extends StatefulWidget {
  SelectLocation({
    super.key,
    this.borderRadius,
    this.locationList = const [],
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
    this.appBarBackgroundColorChooseScreen,
    this.titleTextField,
    this.title,
  });

  final bool showChooseScreen;
  final BorderRadius? borderRadius;
  final List<dynamic> locationList;
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
  final Color? appBarBackgroundColorChooseScreen;
  final String? titleTextField;
  final String? title;

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  late String? selectedText;

  @override
  void initState() {
    super.initState();
    selectedText = widget.text;
  }

  void _navigateAndSelect() async {
    if (!widget.isEnabled || widget.isLoading) return;

    if (widget.showChooseScreen) {
      if (widget.locationList.isEmpty) return;

      final result = await Navigator.push<Map<String, dynamic>>(
        context,
        MaterialPageRoute(
          builder:
              (_) => ChooseScreen(
                locationList: widget.locationList,
                selectedLocation: selectedText,
                hintText: widget.hintText ?? widget.text,
                noDataIcon: widget.noDataIcon,
                noDataText: widget.noDataText,
                appBarBackgroundColor: widget.appBarBackgroundColorChooseScreen,
                title: widget.titleTextField,
              ),
        ),
      );

      if (result != null && mounted) {
        setState(() {
          selectedText = result["value"];
          widget.text = selectedText;
        });
        widget.onSelected?.call(result["index"]);
      }
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle =
        widget.textStyle ??
        TextStyle(
          color: widget.isEnabled ? Colors.black : Colors.black,
          fontSize: 16,
        );

    return GestureDetector(
      onTap: _navigateAndSelect,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: Border.all(
            width: widget.borderWidth,
            color: widget.borderColor!,
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
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                          : Text(
                            selectedText ??
                                widget.hintText ??
                                widget.title.toString(),
                            style: effectiveTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                ),
                if (!widget.isLoading &&
                    widget.showChooseScreen &&
                    widget.isEnabled)
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({
    super.key,
    required this.locationList,
    this.hintText,
    this.selectedLocation,
    this.noDataIcon,
    this.noDataText,
    this.appBarBackgroundColor,
    this.title,
  });

  final List<dynamic> locationList;
  final String? hintText;
  final String? selectedLocation;
  final String? noDataText;
  final IconData? noDataIcon;
  final Color? appBarBackgroundColor;
  final String? title;

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  List<dynamic> filteredData = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredData = widget.locationList;
    if (widget.selectedLocation != null) {
      _controller.text = widget.selectedLocation!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _filterData(String query) {
    setState(() {
      filteredData =
          widget.locationList
              .where(
                (item) =>
                    item.toString().toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void _selectItem(String value) {
    final index = widget.locationList.indexOf(value);
    Navigator.pop(context, {"value": value, "index": index});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.appBarBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: 50,
          child: TextField(
            onChanged: _filterData,
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hintText ?? "Search...",
              // labelText: widget.title ?? "Hello",
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ),
      body:
          filteredData.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(widget.noDataIcon, size: 50, color: Colors.grey),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () => _selectItem(value.toString()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          border: const Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                          color:
                              value.toString() == widget.selectedLocation
                                  ? Colors.grey[200]
                                  : Colors.transparent,
                        ),
                        child: Text(value.toString()),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
