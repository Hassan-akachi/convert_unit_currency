import 'package:convert_unit_currency/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constant/style.dart';
import '../../../network/unit_network_service.dart';

class ConversionScreen extends StatefulWidget {
  static const String routeName = "/conversion";

  final String itemTitle;

  const ConversionScreen({super.key, required this.itemTitle});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  late FixedExtentScrollController scrollController;
  TextEditingController inputController = TextEditingController();
  int index1 = 0;
  int index2 = 0;
  String result = "0.00";
  List<String>? units = [];
  List<dynamic> siUnits = [];

  Future<List<String>> getUnits() async {
    siUnits = await UnitNetworkService().getMeasurementUnits(widget.itemTitle);
    return siUnits.cast<String>();
  }

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index1);
    inputController.addListener(() {});
    getUnits().then((value) {
      setState(() {
        units = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final formkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemTitle),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: size.height * .07,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  scrollController.dispose();
                  scrollController =
                      FixedExtentScrollController(initialItem: index1);
                  //showUnitDialog(context, "from");
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => FutureBuilder<List<dynamic>>(
                          future: getUnits(),
                          //getUnits(str)
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              //final units = snapshot.data!;
                              final units = snapshot.data as List<String>;
                              return CupertinoActionSheet(
                                actions: [builtBottom(units)],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text("Select Unit"),
                                  onPressed: () async{
                                    result = await UnitNetworkService().convertUnits(
                                      units: widget.itemTitle,
                                      from: units![index1],
                                      to: units![index2],
                                      value: inputController.text,
                                    );
                                    setState(() {
                                      result = result;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }
                          }));
                  //  showBottomPicker(context);
                },
                child: Card(
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          units != null && units!.isNotEmpty
                              ? units![index1]
                              : "--",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            TextFormField(
              decoration: kEmailEditTextDecoration.copyWith(hintText: "0.00",),
              textAlign: TextAlign.center,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              keyboardType: TextInputType.number,
              controller: inputController,
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (value) async {
                // print("units -${widget.itemTitle}    from-${units![index]}     to-${units![index2]}          value-${value}");
                // Call your service to get the result
                result = await UnitNetworkService().convertUnits(
                  units: widget.itemTitle,
                  from: units![index1],
                  to: units![index2],
                  value: value,
                );

                // Update the state to trigger a rebuild
                setState(() {
                  result =
                      result; // or directly set it: result = await UnitNetworkService()...
                });
              },
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const Icon(
              Icons.swap_vert,
              color: GlobalColor.secondaryColor,
              size: 50,
            ),
            SizedBox(
              height: size.height * .03,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => FutureBuilder<List<dynamic>>(
                        future: getUnits(),
                        //getUnits(str)
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            //final units = snapshot.data!;
                            final units = snapshot.data as List<String>;
                            return buildDialog(units);
//
                          }
                        }));

                // showUnitDialog(context, "to");
              },
              child: Card(
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        units != null && units!.isNotEmpty
                            ? units![index2]
                            : "--",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            GestureDetector(
                child: Text(
                    result != null && result.isNotEmpty ? result : "0.0",
                    style: const TextStyle(fontSize: 20)),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: result)).then(
                    (_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Copied to Clipboard"),
                      ));
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget builtBottom(List<String> units) {
    return Container(
      width: double.maxFinite,
      height: 250,
      alignment: Alignment.center,
      child: CupertinoPicker(
          scrollController: scrollController,
          itemExtent: 50.0,
          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
            background: CupertinoColors.activeGreen.withOpacity(0.2),
          ),
          onSelectedItemChanged: (index) {
            setState(() => this.index1 = index);
            final unit = units[index];
          },
          children: units
              .map((String siunit) => GestureDetector(
                    onTap: () {},
                    child: Center(
                        child: Text(
                      siunit,
                      textAlign: TextAlign.center,
                    )),
                  ))
              .toList()),
    );
  }

  Widget buildDialog(List<String> units) {
    return SimpleDialog(
        backgroundColor: GlobalColor.secondaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: const Text("Select Level"),
        children: [
          SizedBox(
              //margin: const EdgeInsets.only(right: 10, left: 10, top: 200),
              //height: double.maxFinite,
              width: double.maxFinite,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: units.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SimpleDialogOption(
                      child: InkWell(
                          onTap: () async {
                            setState(() {
                              this.index2 = index;
                            });
                            result = await UnitNetworkService().convertUnits(
                              units: widget.itemTitle,
                              from: units![index1],
                              to: units![index2],
                              value: inputController.text,
                            );
                            setState(() {
                              result = result;
                            });
                            Navigator.pop(context);

                          },
                          child: ListTile(
                            title: Text(units[index]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          )),
                    );
                  })),
        ]);
  }
}
