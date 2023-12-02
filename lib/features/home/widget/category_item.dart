import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryItem extends StatelessWidget {
 final  IconData FontAwesomeIcons;
 final String unitTitle;
 final VoidCallback onTap;
  const CategoryItem({super.key, required this.FontAwesomeIcons, required this.unitTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(10),
        child:  Column(children: [
            FaIcon(FontAwesomeIcons),
          Text(unitTitle)
        ],),
      ),
    );
  }
}
