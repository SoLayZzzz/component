import 'package:flutter/material.dart';

class SelectLocation extends StatefulWidget {
  SelectLocation({
    super.key,
    this.borderRadius,
    this.locationList = const ["Location 1", "Location 2"],
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
    this.iconData = Icons.abc,
    this.text,
    this.showChooseScreen = false,
    this.onTap,
  });

  final bool showChooseScreen;
  final BorderRadius? borderRadius;
  final List<dynamic> locationList;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final IconData? iconData;
  String? text;
  final VoidCallback? onTap;

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  String selectedLocation = "Choose Location";

  void _navigateAndSelect() async {
    if (widget.showChooseScreen) {
      final result = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder:
              (_) => ChooseScreen(
                locationList: widget.locationList,
                selectedLocation: widget.text,
                hintText: widget.text,
              ),
        ),
      );
      if (result != null && result.isNotEmpty) {
        setState(() {
          widget.text = result;
        });
        widget.onTap?.call();
      }
    } else {
      widget.onTap?.call();
    }
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (context) => ChooseScreen(
    //           locationList: widget.locationList,
    //           selectedLocation: widget.text,
    //           hintText: widget.text,
    //         ),
    //   ),
    // );

    // if (result != null && result is String) {
    //   setState(() {
    //     widget.text = result;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _navigateAndSelect,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: Border.all(width: 1, color: Colors.grey),
        ),

        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(widget.iconData),
              ),
              Text(widget.text.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

// Choose option

class ChooseScreen extends StatefulWidget {
  ChooseScreen({
    super.key,
    required this.locationList,
    this.hintText,
    this.selectedLocation,
  });

  final List<dynamic> locationList;
  final String? hintText;
  final String? selectedLocation;
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

  // For Search
  void _filterData(String query) {
    setState(() {
      filteredData =
          widget.locationList
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  // Show data in TextFiled
  void _selectItem(String value) {
    _controller.text = value;
    _filterData(value);
    Navigator.pop(context, value);
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
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            var res = filteredData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () => _selectItem(res),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Row(children: [SizedBox(width: 10), Text(res)]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
