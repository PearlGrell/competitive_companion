import 'dart:convert';
import 'dart:developer';

import 'package:cp_api/models/codechef_model.dart';
import 'package:cp_api/models/codeforces_model.dart';
import 'package:cp_api/models/gfg_model.dart';
import 'package:cp_api/models/leetcode_model.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseURL = "https://cp-api-aryan-trivedi.vercel.app";

  static Future<Map<String, dynamic>> getUserInfo(String handle) async {
    String url = '$baseURL/fetch-all/$handle';
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
      return platformModels;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<CodeforcesContest> getContest(
      String platform, List<String> usernames, String contestId) async {
    String url = '$baseURL/contest/$platform';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usernames': usernames,
        'contestId': contestId,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      CodeforcesContest contest = CodeforcesContest.fromJson(data);
      return contest;
    } else {
      log('Failed to load contest: ${response.body}');
      throw Exception('Failed to load contest data');
    }
  }

  static Future<CodeforcesContest> getContestLatest(
      String platform, List<String> usernames) async {
    String url = '$baseURL/contest/$platform/latest';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usernames': usernames,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      CodeforcesContest contest = CodeforcesContest.fromJson(data);
      return contest;
    } else {
      log('Failed to load contest latest: ${response.body}');
      throw Exception('Failed to load contest data');
    }
  }

  static Future<CodeforcesContest> getContestCurrent(
      String platform, List<String> usernames) async {
    String url = '$baseURL/contest/$platform/current';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usernames': usernames,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      CodeforcesContest contest = CodeforcesContest.fromJson(data);

      return contest;
    } else {
      log('Failed to load contest upcoming: ${response.body}');
      throw Exception('Failed to load contest data');
    }
  }

  static Future<List<Map<String, dynamic>>> getUpcomingContests(String platform) async {
    String url = '$baseURL/contest/$platform/upcoming';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> contests = data.map((contest) {
        return {
          'contestId': contest['contestId'],
          'contestName': contest['contestName'],
          'startTime': contest['startTime'],
        };
      }).toList();
      return contests;
    } else {
      log('Failed to load upcoming contests: ${response.body}');
      throw Exception('Failed to load contest data');
    }
  }
}
