import 'package:hgv2/api/codechef_service.dart';
import 'package:hgv2/api/codeforces_service.dart';
import 'package:hgv2/api/gfg_service.dart';
import 'package:hgv2/api/leetcode_service.dart';
import 'package:hgv2/models/codechef_model.dart';
import 'package:hgv2/models/codeforces_model.dart';
import 'package:hgv2/models/gfg_model.dart';
import 'package:hgv2/models/leetcode_model.dart';

class API {
  static Future<List<Map<String, dynamic>>> getUserInfo(String handle) async {
    CodeChefModel codeChefModel = await CodeChefService.getUserInfo(handle);
    CodeforcesModel codeforcesModel = await CodeforcesService.getUserInfo(handle);
    LeetCodeModel leetCodeModel = await LeetCodeService.getUserInfo(handle);
    GeeksForGeeksModel geeksForGeeksModel = await GeeksForGeeksService.getUserInfo(handle);

    List<Map<String, dynamic>> result = [];
    result.add({"platform": "codechef", "data": codeChefModel});
    result.add({"platform": "codeforces", "data": codeforcesModel});
    result.add({"platform": "leetcode", "data": leetCodeModel});
    result.add({"platform": "geeksforgeeks", "data": geeksForGeeksModel});

    return result;
  }
}
