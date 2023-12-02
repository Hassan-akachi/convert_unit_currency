import 'package:flutter/material.dart';

import '../../conversion/screen/conversion_screen.dart';


class AllUnits extends StatefulWidget {
  final List<dynamic> SiUnit;
  const AllUnits({super.key, required this.SiUnit});

  @override
  State<AllUnits> createState() => _AllUnitsState();
}

class _AllUnitsState extends State<AllUnits> {

  
  
  @override
  Widget build(BuildContext context) {
    if (widget.SiUnit.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
          itemCount: widget.SiUnit.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.SiUnit[index]),
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.pushNamed(context, ConversionScreen.routeName,
                    arguments: widget.SiUnit[index]);
              },
            );

          });
    }
  }
}
