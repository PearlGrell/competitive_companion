import 'dart:convert';
import 'package:hgv2/models/leetcode_model.dart';
import 'package:http/http.dart' as http;

class LeetCodeService {
  static const String baseUrl = 'https://leetcode.com/graphql';

  static Future<LeetCodeModel> getUserInfo(String username) async {
    const String query = '''
    query getUserData(\$username: String!) {
      matchedUser(username: \$username) {
        username
        profile {
          realName
          countryName
          company
          school
        }
        submitStats {
          acSubmissionNum {
            difficulty
            count
          }
        }
        badges {
          displayName
        }
      }
    }
    ''';

    final Map<String, dynamic> body = {
      'query': query,
      'variables': {'username': username},
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (json['data']?['matchedUser'] != null) {
          return LeetCodeModel.fromJson(json['data']['matchedUser']);
        } else {
          print('No data found for username: $username');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }

    return _getDefaultLeetCodeModel();
  }

  static LeetCodeModel _getDefaultLeetCodeModel() {
    return LeetCodeModel(
      username: 'N/A',
      name: 'N/A',
      solvedProblem: 0,
      badges: 0,
      country: 'N/A',
      company: 'N/A',
      school: 'N/A',
    );
  }
}
