// import 'package:convert_unit_currency/constant/data.dart';
// import 'package:flutter/material.dart';
//
// import '../../constant/color.dart';
//
// // const List<String> unitList = [
// //   "weight",
// //   "Length",
// //   "Length",
// //   "Length",
// //   "Length",
// //   "Length",
// //   "Length"
// // ];
//
// showUnitDialog(BuildContext context, String cond) => showDialog(
//     context: context,
//     builder: (context) {
//       // List unitList= unitList;
//       return SimpleDialog(
//           backgroundColor: GlobalColor.secondaryColor,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0))),
//           title: Text("Select Level"),
//           children: [
//             Container(
//                 //margin: const EdgeInsets.only(right: 10, left: 10, top: 200),
//                  //height: double.maxFinite,
//                 width: double.maxFinite,
//                 child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: unitList.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return SimpleDialogOption(
//                         child:
//                         InkWell(
//                             onTap: () {
//
//                             },
//                             child: ListTile(
//                               title: Text(unitList[index]),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             )),
//                       );
//                     }))
//           ]);
//     });
//
//
