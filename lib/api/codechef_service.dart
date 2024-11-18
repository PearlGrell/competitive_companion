import 'package:hgv2/models/codechef_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class CodeChefService {
  static const String baseUrl = 'https://www.codechef.com/users/';

  static Future<CodeChefModel> getUserInfo(String username) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$username'));

      if (response.statusCode == 200) {
        var document = parse(response.body);

        String name = _getUserInfo(document, '.h2-style');
        String userName = _getUserInfo(document, '.m-username--link');
        String rating = _getUserInfo(document, '.rating-header .rating-number');
        String maxRating = _getMaxRating(document);

        var rankElements = document.querySelectorAll('.rating-ranks strong');
        String globalRank = rankElements.isNotEmpty ? rankElements[0].text : 'N/A';
        String countryRank = rankElements.length > 1 ? rankElements[1].text : 'N/A';

        return CodeChefModel(
          name: name,
          username: userName,
          rating: rating,
          maxRating: maxRating,
          globalRank: globalRank,
          countryRank: countryRank,
        );
      } else {
        throw Exception('Failed to load CodeChef user data');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching user data: $e');
    }
  }

  static String _getUserInfo(var document, String selector) {
    return document.querySelector(selector)?.text.trim() ?? 'N/A';
  }

  static String _getMaxRating(var document) {
    String? maxRatingText = document.querySelector('.rating-header small')?.text;
    return maxRatingText != null
        ? maxRatingText.split(' ')[2].replaceAll(')', '')
        : 'N/A';
  }

}
