// import 'package:convert_unit_currency/constant/color.dart';
// import 'package:convert_unit_currency/constant/data.dart';
// import 'package:convert_unit_currency/network/unit_network_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class ShowBottomPicker extends StatefulWidget {
//   final List<String> units;
//   const ShowBottomPicker({super.key, required this.units});
//
//   @override
//   State<ShowBottomPicker> createState() => _ShowBottomPickerState();
// }
//
// class _ShowBottomPickerState extends State<ShowBottomPicker> {
//   late FixedExtentScrollController scrollController;
//   int index=0;
//
//   @override
//   void initState() {
//     super.initState();
//     //scrollController.dispose();
//     scrollController =FixedExtentScrollController(initialItem: index );
//
//   }
//
//
//   @override
//   void dispose() {
//   super.dispose();
//   scrollController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       width: double.maxFinite,
//       height: 250,
//       alignment: Alignment.center,
//       child: CupertinoPicker(
//           scrollController: scrollController,
//           itemExtent: 50.0,
//           selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
//             background: CupertinoColors.activeGreen.withOpacity(0.2),
//           ),
//           onSelectedItemChanged: (index) {
//              setState(()=>this.index =index);
//             final unit= widget.units[index];
//           },
//           children: getUnit(widget.units)),
//     );
//
//
//   }
// }
//
//
// void showBottomPicker(BuildContext ctx) {
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
//       elevation: 10,
//       backgroundColor: GlobalColor.secondaryColor,
//       context: ctx,
//       builder: (ctx) => Container(
//           width: double.maxFinite,
//           height: 250,
//           alignment: Alignment.center,
//           child: CupertinoPicker(
//             itemExtent: 50.0,
//             onSelectedItemChanged: (int value) {},
//             children: getSiUnit(unitList, "to"),
//           )
//           // const Text('Breathe in... Breathe out...'),
//           ));
// }
//
// List<Widget> getPickerItems() {
//   List<Text> pickerItems = [];
//   for (String item in unitList) {
//     pickerItems.add(Text(item));
//   }
//   return pickerItems;
// }
//
// List<Widget> getSiUnit(List<String> unitList, String cond) => unitList
//     .map((String siunit) => GestureDetector(
//           onTap: () {
//             if (cond == "from") {
//             } else
//               ;
//           },
//           child: Center(
//               child: Text(
//             siunit,
//             textAlign: TextAlign.center,
//           )),
//         ))
//     .toList();
//
//
//
//
// List<Widget> getUnit(List<String> unitList) => unitList
//     .map((String siunit) => GestureDetector(
//           onTap: () {
//
//           },
//           child: Center(
//               child: Text(
//             siunit,
//             textAlign: TextAlign.center,
//           )),
//         ))
//     .toList();
//
// List<dynamic> siUnits = [];
//
// Future<List> gettestUnits(String str) async {
//   siUnits = (await UnitNetworkService().getMeasurementUnits(str));
//
//   return siUnits;
// }
//
// Future showBottom(String str,BuildContext context) {
//   late FixedExtentScrollController scrollController;
//   int index=0;
//   return showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
//       elevation: 10,
//       backgroundColor: GlobalColor.secondaryColor,
//       context: context,
//       builder: (BuildContext context) {
//         return FutureBuilder<List<dynamic>>(
//             future: UnitNetworkService().getMeasurementUnits(str),
//             //getUnits(str)
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text('Error: ${snapshot.error}'),
//                 );
//               } else {
//                 final List<String> units = snapshot.data as List<String>;
//                 return Container(
//                   width: double.maxFinite,
//                   height: 250,
//                   alignment: Alignment.center,
//                   child: CupertinoPicker(
//                     //scrollController: scrollController,
//                       itemExtent: 50.0,
//                       onSelectedItemChanged: (index) {
//                         // setState(()=>this.index =index);
//                         final unit= units[index];
//                       },
//                       children: getUnit(units)),
//                 );
// //                 ListView.builder(
// //                   itemCount: snapshot.data?.length,
// //                   itemBuilder: (context, index) {
// //                     return ListTile(
// //                       title: Text(snapshot.data?[index]),
// //                       onTap: () {
// // // Handle item tap if needed
// //                         print('Tapped on ${snapshot.data?[index]}');
// //                       },
// //                     );
// //                   },
// //                 ),
//               }
//             });
//       }
//       );
// }
