import 'dart:ffi';

import 'package:convert_unit_currency/constant/color.dart';
import 'package:convert_unit_currency/constant/data.dart';
import 'package:convert_unit_currency/features/conversion/screen/conversion_screen.dart';
import 'package:flutter/material.dart';

import '../../../network/cypto_currency_network_service.dart';
import '../../conversion/screen/cc_conversion_screen.dart';

class CategoryList extends StatefulWidget {
  final String title;
  final int count;

  CategoryList({super.key, required this.title, required this.count});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<dynamic> allCCList = [];
  final List category = getCate();

  Future searchCC(BuildContext context) async {
    final currencyList = await CCNetworkService().getAllCCList('', context);

    // final allCCList =
    //     await CCNetworkService().getAllCpytoCurrency(query, context);
    // final List<MapEntry<String, dynamic>> currencyList =
    //     allCCList.entries.toList();
    if (!mounted) return;
    setState(() {
      this.allCCList = currencyList;
    });
  }


  @override
  void initState() {
 searchCC(context);
 super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: getCate()[widget.count].cateItem.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (widget.title != "Currency" &&
                              widget.title != "Crypto-Currency") {
                            Navigator.pushNamed(
                                context, ConversionScreen.routeName,
                                arguments: getCate()[widget.count]
                                    .cateItem[index]
                                    .itemTitle);
                          } else {

                            String itemTitle = getCate()[widget.count]
                                .cateItem[index]
                                .itemTitle;
                            int position = allCCList.indexWhere(
                              (entry) =>
                                  entry.value.toString().toLowerCase().trim() ==
                                  itemTitle.toLowerCase().trim(),
                            );
                            print('ItemTitle: $itemTitle       sss');
                            print('AllCCList Values: ${allCCList.map((entry) => entry.value.toString())}');

                            if (position != -1) {
                              Navigator.pushNamed(
                                context,
                                CCConversionScreen.routeName,
                                arguments: position,
                              );
                            } else {
                              // Handle the case when the itemTitle is not found in allCCList
                              print('Item not found: $itemTitle');
                              // You might want to show an error message or take a different action
                            }
                          }
                        },
                        splashColor: GlobalColor.secondaryColor,
                        focusColor: GlobalColor.secondaryColor,
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            border:
                                Border.all(color: GlobalColor.secondaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                getCate()[widget.count].cateItem[index].icon,
                                color: GlobalColor.secondaryColor,
                              ),
                              Text(
                                getCate()[widget.count]
                                    .cateItem[index]
                                    .itemTitle,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
