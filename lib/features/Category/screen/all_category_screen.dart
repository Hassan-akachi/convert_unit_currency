import 'dart:async';

import 'package:convert_unit_currency/network/cypto_currency_network_service.dart';
import 'package:flutter/material.dart';

import '../../../constant/color.dart';
import '../../../network/unit_network_service.dart';
import '../widget/all_crypto_currency.dart';
import '../widget/all_unit.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final searchController = TextEditingController();
  String query = '';
  int tabIndex = 0;
  Timer? debouncer;
  List<dynamic> allSiUnits = [];
  List<dynamic> allCCList = [];

  // Future<List<String>> getAllUnits() async {
  //   allSiUnits = (await UnitNetworkService().getAllMeasurements())!;
  //   return allSiUnits.cast<String>();
  // }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future initUnit(String query) async {
        final allSiUnits =
            (await UnitNetworkService().getAllMeasurements(query, context));

        // if (!mounted) return;
        setState(() {
          // this.query = query;
          this.allSiUnits = allSiUnits;
        });
      }

  Future searchUnit(String query) async => debounce(() async {
    final allSiUnits =
    (await UnitNetworkService().getAllMeasurements(query, context))!;

    if (!mounted) return;
    setState(() {
      this.query = query;
      this.allSiUnits = allSiUnits;
    });
  });

  Future searchCC(String query) async => debounce(() async {
        final currencyList =
            await CCNetworkService().getAllCCList(query, context);

        // final allCCList =
        //     await CCNetworkService().getAllCpytoCurrency(query, context);
        // final List<MapEntry<String, dynamic>> currencyList =
        //     allCCList.entries.toList();
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.allCCList = currencyList;
        });
      });

  // int getTabIndex() {
  //   setState(() {
  //     tabIndex = controller.index;
  //   });
  //   return tabIndex;
  // }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {});
    });

    initUnit(query);
    // searchUnit(query);
    searchCC(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text('All Category ${controller.index} '),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         // showSearch(
        //         //     context: context, delegate: MySearchDelegate(tabNum));
        //       },
        //       icon: const Icon(Icons.search)),
        // ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: searchUnitWidget()),
      ),
      body: Column(children: [
        TabBar(
            indicatorColor: GlobalColor.secondaryColor,
            labelColor: GlobalColor.secondaryColor,
            controller: controller,
            labelPadding: const EdgeInsets.symmetric(horizontal: 70),
            isScrollable: true,
            tabs: const [
              Tab(
                text: "Units",
              ),
              Tab(
                text: "Crypto/Currency",
              )
            ]),
        Expanded(
            child: TabBarView(controller: controller, children: [
          AllUnits(
            SiUnit: allSiUnits,
          ),
          AllCryptoCurrency(
            allCC: allCCList,
          )
        ]))
      ]),
    );
    // TabBarView(
    //     controller: controller,
    //     children: const [AllUnits(), AllCryptoCurrency()]));
  }

  @override
  void dispose() {
    controller.dispose();
    debouncer?.cancel();
    super.dispose();
  }

  Widget searchUnitWidget() {
    const styleActive = TextStyle(color: Colors.black);
    const styleHint = TextStyle(color: Colors.black26);
    final style = query.isEmpty ? styleHint : styleActive;
    return Container(
      height: 42,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: query.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    searchController.clear();

                      initUnit('');

                      searchCC('');

                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: "unit,currency or crypto",
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: controller.index == 0 ? searchUnit : searchCC,
      ),
    );
  }
}
