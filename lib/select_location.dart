import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectLocation extends StatefulWidget {
  SelectLocation({
    super.key,
    this.borderRadius,
    this.locationList = const ["Location 1", "Location 2"],
    this.height = 65,
    this.width = double.infinity,
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
  });

  final bool showChooseScreen;
  final BorderRadius? borderRadius;
  final List<dynamic> locationList;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final AssetImage? assetImage;
  String? text;
  final VoidCallback? onTap;
  final ValueChanged<int>? onSelected; // Add this for index callback
  final String? noDataText;
  final IconData? noDataIcon;
  final TextStyle? textStyle;

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
    if (widget.showChooseScreen) {
      final result = await Navigator.push<Map<String, dynamic>>(
        context,
        MaterialPageRoute(
          builder:
              (_) => ChooseScreen(
                locationList: widget.locationList,
                selectedLocation: selectedText,
                hintText: widget.text,
                noDataIcon: widget.noDataIcon,
                noDataText: widget.noDataText,
              ),
        ),
      );
      if (result != null) {
        setState(() {
          selectedText = result["value"];
          widget.text = selectedText; // keep in sync
        });
        if (widget.onSelected != null) {
          widget.onSelected!(result["index"]);
        }
      }
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateAndSelect,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: Border.all(
            width: widget.borderWidth,
            color: widget.borderColor!,
          ),
        ),
        child: Center(
          child: Row(
            children: [
              if (widget.assetImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image(image: widget.assetImage!, width: 30),
                ),
              Expanded(
                child: Text(
                  selectedText ?? '',
                  style:
                      widget.textStyle ??
                      const TextStyle(color: Colors.black, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Choose option screen returning a Map with value + index
class ChooseScreen extends StatefulWidget {
  const ChooseScreen({
    super.key,
    required this.locationList,
    this.hintText,
    this.selectedLocation,
    this.noDataIcon,
    this.noDataText,
  });

  final List<dynamic> locationList;
  final String? hintText;
  final String? selectedLocation;
  final String? noDataText;
  final IconData? noDataIcon;

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
        actions: [
          SizedBox(
            height: 50,
            width: 320,
            child: TextField(
              onChanged: _filterData,
              controller: _controller,
              autofocus: false,
              decoration: InputDecoration(
                hintText: widget.hintText ?? "Search...",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),
        ],
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
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                          color: Colors.transparent,
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
