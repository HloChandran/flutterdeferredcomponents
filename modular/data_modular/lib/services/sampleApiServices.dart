import 'dart:convert';
import 'dart:developer';
import 'package:data_modular/Model/DataModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<DataModel?> getApiDetails() async {
  DataModel? result;
  try {
    final response =
        await http.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DataModel.fromJson(item);
      if (kDebugMode) {
        print("result${response.body}");
      }
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
