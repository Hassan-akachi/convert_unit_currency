import 'dart:convert';
import 'package:convert_unit_currency/constant/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constant/util.dart';

class UnitNetworkService {

  var client = http.Client();

  final StringBuffer stringBuffer = StringBuffer(Constant.UnitBaseUrl);
  static Map<String, String> _getHeaders() =>
      {
        'X-RapidAPI-Key': Constant.unitApiKey,
        'X-RapidAPI-Host': 'measurement-unit-converter.p.rapidapi.com'
      };




  Future<List<dynamic>> getAllMeasurements(String query,BuildContext context) async {
    var url = Uri.parse(
        'https://measurement-unit-converter.p.rapidapi.com/measurements');
    var headers = {
      'X-RapidAPI-Key': Constant.unitApiKey,
      'X-RapidAPI-Host': 'measurement-unit-converter.p.rapidapi.com'
    };

    List<String> allUnits=[];
    try {
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> units = jsonDecode(response.body);
        allUnits = units.map((unit) => unit.toString()).where((element) {
          final titleLower = element.toLowerCase();
          final searchLower = query.toLowerCase();

          return titleLower.contains(searchLower);
        }).toList();
        return allUnits;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      if(context.mounted){
      showSnackBar(context, error.toString());}
    }
    return allUnits;
  }



  Future<List<dynamic>> getMeasurementUnits(String units) async {

    stringBuffer.write("/${units.toLowerCase().trim()}/units");
    var url = Uri.parse(stringBuffer.toString());//"${Constant.kBaseUrl}curated?per_page=15&page=1"

    // var url = Uri.parse(
    //     'https://measurement-unit-converter.p.rapidapi.com/length/units');

    List<String> unitNames=[];
    try {
      http.Response response = await client.get(url, headers: _getHeaders());

      if (response.statusCode == 200) {
        List<dynamic> units = jsonDecode(response.body);
         unitNames = units.map((unit) => unit.toString()).toList();
        return unitNames;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');

    }
    return unitNames;
  }


  Future<String> convertUnits({required String units,required String from,required String to,required String value}) async {

    stringBuffer.write("/${units.toLowerCase().trim()}");
    var url = Uri.parse(stringBuffer.toString());


    // var url = Uri.parse(
    //     'https://measurement-unit-converter.p.rapidapi.com/length/units');
    var params = {'value': value.trim(), 'from': from.trim(), 'to': to.trim()};
    // url =Uri.http(Constant.UnitBaseUrl,"/${units.toLowerCase().trim()}",params );
     String result ="";
    try {
      http.Response response = await client.get( Uri(
        scheme: url.scheme,
        host: url.host,
        path: url.path,
        queryParameters: params,
      ), headers: _getHeaders(),);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        result =responseMap['result'];
        return result;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');

    }
return result;
  }


}