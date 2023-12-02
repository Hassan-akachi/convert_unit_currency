// import 'package:convert_unit_currency/constant/color.dart';
// import 'package:convert_unit_currency/features/conversion/screen/conversion_screen.dart';
// import 'package:flutter/material.dart';
//
// import '../../../constant/data.dart';
//
//
//
// class SearchScreen extends StatefulWidget {
//   static const String routeName = "/search";
//
//
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final searchController =TextEditingController();
//   String query ="";
//   List unit = unitList; // Define the unit property
//   void search(String query){
//     final unit = unitList.where((element) {
//       final titleLower = element.toLowerCase();
//       final searchLower = query.toLowerCase();
//
//       return titleLower.contains(searchLower);
//     }).toList();
//
//     setState(() {
//       this.query = query;
//       this.unit =unit;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final styleActive =TextStyle(color: Colors.black);
//     final styleHint =TextStyle(color: Colors.black26);
//     final style= query.isEmpty ? styleHint : styleActive;
//
//
//     return Scaffold(
//       appBar: AppBar(title:  Expanded(
//         child: Container(
//           height: 42,
//           margin: const EdgeInsets.only(top: 16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.white,
//             border: Border.all(color: Colors.black26),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: TextField(
//             controller: searchController,
//             decoration:  InputDecoration(
//               icon: Icon(Icons.search,color: style.color),
//               suffixIcon: query.isNotEmpty ?
//               GestureDetector(
//                 child: Icon(Icons.close,color: style.color),
//                 onTap: (){
//                   searchController.clear();
//                   search('');
//                   FocusScope.of(context).requestFocus(FocusNode());
//                 },
//               ):null,
//               hintText: "unit,currency or crypto",
//               hintStyle: style ,
//               border: InputBorder.none,
//             ),
//             style: style ,
//             onChanged: search ,
//           ),
//         ),
//       ),),
//       body: Column(
//         children: [
//           Container(
//             height: 42,
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.white,
//               border: Border.all(color: Colors.black26),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: TextField(
//               controller: searchController,
//               decoration:  InputDecoration(
//                 icon: Icon(Icons.search,color: style.color),
//                 suffixIcon: query.isNotEmpty ?
//               GestureDetector(
//                 child: Icon(Icons.close,color: style.color),
//                 onTap: (){
//                   searchController.clear();
//                   search('');
//                   FocusScope.of(context).requestFocus(FocusNode());
//                 },
//               ):null,
//                 hintText: "unit,currency or crypto",
//                   hintStyle: style ,
//                   border: InputBorder.none,
//               ),
//               style: style ,
//               onChanged: search ,
//             ),
//           ),
//           Expanded(
//             child: SizedBox(
//               //margin: const EdgeInsets.only(right: 10, left: 10, top: 200),
//               //height: double.maxFinite,
//                 width: double.maxFinite,
//                 child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: unit.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
//                         title: Text(unit[index]),
//                         trailing: const Icon(Icons.arrow_forward_ios),
//                         onTap: (){
//                           FocusScope.of(context).unfocus();
//                           Navigator.pushNamed(context, ConversionScreen.routeName,arguments:unit[index] );
//                         },
//                       );
//                     })),
//           )
//         ],
//       ),
//
//     );
//   }
//
// }
