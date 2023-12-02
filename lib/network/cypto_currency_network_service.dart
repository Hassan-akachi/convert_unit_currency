import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constant/error_handling.dart';
import '../constant/strings.dart';
import '../constant/util.dart';

class CCNetworkService {
  var client = http.Client();
  final StringBuffer stringBuffer = StringBuffer(Constant.CCBaseUrl);



  Future<List<MapEntry<String, dynamic>>> getAllCCList(
      String query, BuildContext context) async {
    stringBuffer.write("currencies.json");
    var url = Uri.parse(stringBuffer.toString());
    List<MapEntry<String, dynamic>> data = [];

    try {
      http.Response response = await client.get(url);
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            Map<String, dynamic> units = jsonDecode(response.body);
            data = units.entries
                .where((entry) {
              final titleLower = entry.value.toString().toLowerCase();
              final searchLower = query.toLowerCase();
              return titleLower.contains(searchLower);
            })
                .toList();
            return data;
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      if (context.mounted) {
        showSnackBar(context, error.toString());
      }
    }

    return data;
  }





  Future<Map<String, dynamic>> getAllCpytoCurrency(
      BuildContext context) async {
    stringBuffer.write("currencies.json");
    var url = Uri.parse(stringBuffer.toString());
    Map<String, dynamic> data = {};

    try {
      http.Response response = await client.get(url);
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            // List<dynamic> ccList = jsonDecode(response.body);
            // ccAll = ccList.map((unit) => unit.toString()).toList();

            data = jsonDecode(response.body);
            return data;
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      if (context.mounted) {
        showSnackBar(context, error.toString());
      }
    }

    //   if (response.statusCode == 200) {
    //     List<dynamic> ccList = jsonDecode(response.body);
    //     ccAll = ccList.map((unit) => unit.toString()).toList();
    //     return ccAll;
    //   } else {
    //     throw Exception('Failed to load data');
    //   }
    // } catch (error) {
    //   print('Error: $error');
    //
    // }
    return data;
  }





  Future<double> fetchCurrency({required String from,
      required String to,
      required BuildContext context}) async {
    stringBuffer
        .write("currencies/${from.toLowerCase().trim()}/${to.toLowerCase().trim()}.json");
    final url = Uri.parse(stringBuffer.toString());
    var result =0.00;
    try {
      final response = await http.get(url);

      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            // List<dynamic> ccList = jsonDecode(response.body);
            // ccAll = ccList.map((unit) => unit.toString()).toList();
            final Map<String, dynamic> data = jsonDecode(response.body);
            result = data[to.toString()];
            print(data[to.toString()]);
            return result;
          },
        );
      }

      // if (response.statusCode == 200) {
      //   // Parse the JSON response
      //   final Map<String, dynamic> data = jsonDecode(response.body);
      //   result = data[to.toString()];
      //   print(data);
      //   return data;
      // } else {
      //   throw Exception('Failed to load currencies. Status code: ${response.statusCode}');
      // }
    } catch (error) {
      print('Error: $error');
      if (context.mounted) {
        showSnackBar(context, error.toString());
      }
    }
    return result;
  }

}
