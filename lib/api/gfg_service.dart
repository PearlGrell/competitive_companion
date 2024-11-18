import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:hgv2/models/gfg_model.dart';

class GeeksForGeeksService {
  static const String baseUrl = 'https://auth.geeksforgeeks.org/user/';

  static Future<GeeksForGeeksModel> getUserInfo(String username) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$username/practice/'));
      if (response.statusCode == 200) {
        var document = parse(response.body);
        String userName = username;
        String name = document.querySelector('.userName')?.text.trim() ?? userName;
        String profile = document.querySelector('.profile_pic')?.attributes['src'] ?? '';
        String instituteRank = document.querySelector('.rankNum')?.text.trim() ?? 'N/A';
        var streakElement = document.querySelector('.streakCnt');
        String currentStreak = '00', maxStreak = '00';
        if (streakElement != null) {
          var streakDetails = streakElement.text.replaceAll(' ', '').split('/');
          if (streakDetails.length == 2) {
            currentStreak = streakDetails[0];
            maxStreak = streakDetails[1];
          }
        }
        String institution = document.querySelector('.basic_details_data')?.text.trim() ?? 'N/A';
        var scoreCardElements = document.querySelectorAll('.score_card_value');
        String codingScore = scoreCardElements.isNotEmpty ? scoreCardElements[0].text.trim() : '0';
        String totalProblemsSolved = scoreCardElements.length > 1 ? scoreCardElements[1].text.trim() : '0';
        Map<String, dynamic> solvedStats = {};
        List<String> difficulties = ['school', 'easy', 'medium', 'hard'];
        for (var difficulty in difficulties) {
          var element = document.querySelector('#$difficulty');
          solvedStats[difficulty] = element?.querySelectorAll('a').length ?? 0;
        }
        bool exists = profile.isNotEmpty;

        return GeeksForGeeksModel(
          userName: userName,
          name: name,
          instituteRank: instituteRank,
          currentStreak: currentStreak,
          maxStreak: maxStreak,
          institution: institution,
          codingScore: codingScore,
          totalProblemsSolved: totalProblemsSolved,
          solvedStats: solvedStats,
          exists: exists,
        );
      } else {
        throw Exception('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
