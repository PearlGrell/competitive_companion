import 'dart:convert';

import 'package:hgv2/models/codechef_model.dart';
import 'package:hgv2/models/codeforces_model.dart';
import 'package:hgv2/models/gfg_model.dart';
import 'package:hgv2/models/leetcode_model.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<Map<String, dynamic>> getUserInfo(String handle) async {
    String url = 'https://hgv2-server-two.vercel.app/fetch-all/$handle';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> platformModels = {};

      if (data.containsKey('codeforces')) {
        CodeforcesModel model = CodeforcesModel.fromJson(data['codeforces']);
        platformModels['codeforces'] = model;
      }

      if (data.containsKey('geeksforgeeks')) {
        GeeksForGeeksModel model =
            GeeksForGeeksModel.fromJson(data['geeksforgeeks']);
        platformModels['geeksforgeeks'] = model;
      }

      if (data.containsKey('codechef')) {
        CodeChefModel model = CodeChefModel.fromJson(data['codechef']);
        platformModels['codechef'] = model;
      }

      if (data.containsKey('leetcode')) {
        LeetCodeModel model = LeetCodeModel.fromJson(data['leetcode']);
        platformModels['leetcode'] = model;
      }
      print(platformModels);
      return platformModels;
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
