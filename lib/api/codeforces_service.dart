import 'package:hgv2/models/codeforces_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CodeforcesService {
  static const String baseUrl = 'https://codeforces.com/api';

  static Future<CodeforcesModel> getUserInfo(String handle) async {
    final response = await http.get(Uri.parse('$baseUrl/user.info?handles=$handle'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json['status'] == 'OK' && json['result']?.isNotEmpty == true) {
        return CodeforcesModel.fromJson(json['result'][0]);
      }
    }

    return _getDefaultCodeforcesModel();
  }

  static CodeforcesModel _getDefaultCodeforcesModel() {
    return CodeforcesModel(
      name: 'N/A',
      rating: 0,
      handle: 'N/A',
      contribution: 0,
      rank: 'N/A',
      maxRating: 0,
      maxRank: 'N/A',
    );
  }
}
