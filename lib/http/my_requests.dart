import 'dart:convert';

import 'package:faizan_tentwenty_assignment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MyRequests {
  static Future<dynamic?> getRequest(BuildContext context, String url) async {
    http.Response response = await http.get(Uri.parse(url));
    print(url);
    if (response.statusCode != 200) {
      Utils.showSnackBar(context, 'There was an error!');
      return null;
    }
    return jsonDecode(response.body);
  }
}
