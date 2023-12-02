import 'package:convert_unit_currency/constant/color.dart';
import 'package:convert_unit_currency/features/home/widget/category_list.dart';
import 'package:convert_unit_currency/features/search/screen/search_screen.dart';
import 'package:convert_unit_currency/network/cypto_currency_network_service.dart';
import 'package:flutter/material.dart';

import '../../../constant/data.dart';
import '../../../network/unit_network_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final List category = getCate();
    return Scaffold(
      // appBar: AppBar(leading: IconButton(onPressed: () async {
      //   final allSiUnits =
      //   (await UnitNetworkService().getAllMeasurements('', context))!;
      //   print(allSiUnits);
      // }, icon: Icon(Icons.search),),),
      backgroundColor: GlobalColor.secondaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title Text

           Text(
            "Ultimate Converter",

            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50, ),
          ),

          // Icon in the Center
           Center(
            child: Icon(
              Icons.swap_horizontal_circle_outlined,

              color: Theme.of(context).iconTheme.color,
              size: 100,
            ),
          ),

          // SizedBox for spacing
          const SizedBox(
            height: 10,
          ),

          // Container with a white background
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              // height: double.infinity,
              // width: double.infinity,
              decoration:  BoxDecoration(
                color: Theme.of(context).iconTheme.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),

              // Scrollable content inside the container
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: category.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  // Assuming CategoryList is a custom widget for each category
                  return CategoryList(
                    title: category[index].cateTitle,
                    count: index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
