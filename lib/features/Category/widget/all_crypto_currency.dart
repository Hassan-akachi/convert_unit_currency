import 'package:flutter/material.dart';

import '../../../network/cypto_currency_network_service.dart';
import '../../conversion/screen/cc_conversion_screen.dart';

class AllCryptoCurrency extends StatefulWidget {
  final List<dynamic> allCC;

  const AllCryptoCurrency({super.key, required this.allCC});

  @override
  State<AllCryptoCurrency> createState() => _AllCryptoCurrencyState();
}

class _AllCryptoCurrencyState extends State<AllCryptoCurrency> {
  List initCCList = [];

  Future allCCList() async {
    //gets a
    final currencyList = await CCNetworkService().getAllCCList('', context);

    // if (!mounted) return;
    setState(() {
      // this.query = query;
      initCCList = currencyList;
    });
  }

  @override
  void initState() {
    super.initState();
    allCCList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allCC.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
          itemCount: widget.allCC.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.allCC[index].value),
              onTap: () {
                allCCList();
                print(
                    'AllCCList Values: ${initCCList.map((entry) => entry.value.toString())}');

                int position = initCCList.indexWhere(
                  (entry) =>
                      entry.value.toString().toLowerCase().trim() ==
                      widget.allCC[index].value.toLowerCase().trim(),
                );

                // int position = widget.allCC.indexWhere(
                //       (entry) => entry.key.toString().toLowerCase() == widget.allCC[index].key,
                // );
                Navigator.pushNamed(
                  context,
                  CCConversionScreen.routeName,
                  arguments: position,
                ); //index
              },
            );
          });
    }
  }
}
