import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constant/color.dart';
import '../../../constant/style.dart';
import '../../../network/cypto_currency_network_service.dart';

class CCConversionScreen extends StatefulWidget {
  static const String routeName = "/cc-conversion";


  final int start;

  const CCConversionScreen({super.key,  required this.start});

  @override
  State<CCConversionScreen> createState() => _CCConversionScreenState();
}

class _CCConversionScreenState extends State<CCConversionScreen> {
  late FixedExtentScrollController scrollController;
  TextEditingController inputController = TextEditingController();
  late int index1 ;
  int index2 = 0;
  double value1 =1.0;
  var result ;

  // List<dynamic> allCCList = [];
  List<MapEntry<String, dynamic>>? allCCList;

  Future<List<MapEntry<String, dynamic>>> getCCList() async {
    final allCCList =
        await CCNetworkService().getAllCCList('', context);
    return allCCList;
    ///    important do not delete
    // final allCCList =
    //     await CCNetworkService().getAllCpytoCurrency( context);
    // return allCCList.entries.toList();
  }

  // Future getCCList(String query) async {
  //
  //     final allCCList =
  //     await CCNetworkService().getAllCpytoCurrency(query, context);
  //     final List<MapEntry<String, dynamic>> currencyList =
  //     allCCList.entries.toList();
  //     if (!mounted) return;
  //     setState(() {
  //       // this.query = query;
  //       this.allCCList = currencyList;
  //     });
  //     return allCCList;
  // }

  @override
  void initState() {
    super.initState();
    index1 = widget.start ?? 0;
    scrollController = FixedExtentScrollController(initialItem: index1);
    inputController.addListener(() {});
    getCCList();
    getCCList().then((List<MapEntry<String, dynamic>> value) {
      setState(() {
        allCCList = value;
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

    // final formkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All CRYPTO/CURRENCY"),
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
                      builder: (context) => FutureBuilder(
                          future: getCCList(),
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

                              return CupertinoActionSheet(
                                actions: [builtBottom(allCCList)],
                                //currencyList.cast<String>()
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text("Select Crypto/Currency"),
                                  onPressed: () async {
                                    result = await CCNetworkService()
                                        .fetchCurrency(
                                            from: allCCList![index1].key,
                                            to: allCCList![index2].key,
                                            context: context);

                                    // Update the state to trigger a rebuild
                                    setState(() {
                                      result =
                                          result; // or directly set it: result = await UnitNetworkService()...
                                    });
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
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
                          allCCList != null && allCCList!.isNotEmpty
                              ? allCCList![index1].value
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
              decoration: kEmailEditTextDecoration.copyWith(hintText: "1.00"),
              // readOnly: true,
              // enableInteractiveSelection: false,
              textAlign: TextAlign.center,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              keyboardType: TextInputType.number,
              controller: inputController,
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (value) async {
                result = await CCNetworkService()
                    .fetchCurrency(
                    from: allCCList![index1].key,
                    to: allCCList![index2].key,
                    context: context);

                // Update the state to trigger a rebuild
                setState(() {
                  value1= inputController.text.isEmpty? value1: double.parse(value);
                  result =
                      result * value1; // or directly set it: result = await UnitNetworkService()...
                });
              },
            ),
            SizedBox(
              height: size.height * .03,
            ),
            GestureDetector(onTap: () async {
              result = await CCNetworkService()
                  .fetchCurrency(
                  from: allCCList![index1].key,
                  to: allCCList![index2].key,
                  context: context);

              // Update the state to trigger a rebuild
              setState(() {
               value1= inputController.text.isEmpty? value1: double.parse(inputController.text);
                result =
                    result *value1; // or directly set it: result = await UnitNetworkService()...
              });

            },
              child: const Icon(
                Icons.swap_vert,
                color: GlobalColor.secondaryColor,
                size: 50,
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => FutureBuilder(
                        future: getCCList(),
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
                            // final units = snapshot.data as List<String>;

                            return buildDialog(allCCList);
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
                        allCCList != null && allCCList!.isNotEmpty
                            ? allCCList![index2].value
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
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    child: Text( result != null &&  "${result}".isNotEmpty ?
                    "${result}" : 0.00.toString() ,
                        style: const TextStyle(fontSize: 20)),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: result.toString())).then(
                        (_) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Copied to Clipboard"),
                          ));
                        },
                      );
                    }),
                SizedBox(width: 10,),
                Text( allCCList != null && allCCList!.isNotEmpty
                    ? allCCList![index2].key
                    : "--",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builtBottom(List<MapEntry<String, dynamic>>? CC) {
    // Change the type to List<MapEntry<String, dynamic>>
    if (CC == null) {
      return Container();
    }
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
          final unit = CC[index];
        },
        children: CC
            .map((MapEntry<String, dynamic> entry) => GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      entry.value, // Access the value property of the MapEntry
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget buildDialog(List<MapEntry<String, dynamic>>? CC) {
    // Change the type to List<MapEntry<String, dynamic>>
    if (CC == null) {
      return Container();
    }
    return SimpleDialog(
        backgroundColor: GlobalColor.secondaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),

        title: const Text("Select Crypto/Currency"),
        children: [
          SingleChildScrollView(
            child: SizedBox(
                //margin: const EdgeInsets.only(right: 10, left: 10, top: 200),
                height: 500,
                width: double.maxFinite,
                child: ListView.builder(

                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: CC.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SimpleDialogOption(
                        child: InkWell(
                            onTap: () async {
                              setState(() {
                                this.index2 = index;
                              });
                              result = await CCNetworkService().fetchCurrency(
                                  from: CC[index1].key,
                                  to: CC[index2].key,
                                  context: context);
                              setState(() {
                                value1= inputController.text.isEmpty? value1: double.parse(inputController.text);
                                result =
                                    result *value1;
                              });
                              if(context.mounted){
                              Navigator.pop(context);}
                            },
                            child: ListTile(
                              title: Text(CC[index].value),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            )),
                      );
                    })),
          ),
        ]);
  }
}
