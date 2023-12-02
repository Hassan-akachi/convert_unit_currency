import 'package:flutter/cupertino.dart';

class Cate{
  final String cateTitle;
  final List<CateItem> cateItem;
  Cate({required this.cateTitle, required this.cateItem});
}

class CateItem {
  final IconData icon;
  final String itemTitle;
  CateItem({required this.icon,required this.itemTitle});
}