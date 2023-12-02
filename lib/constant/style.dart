import 'package:convert_unit_currency/constant/color.dart';
import 'package:flutter/material.dart';


const kEmailEditTextDecoration=InputDecoration(
  // fillColor: ,
  // filled: true,
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderSide:
    BorderSide(color: GlobalColor.secondaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: GlobalColor.secondaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color:GlobalColor.secondaryColor , width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);