class LeetCodeModel {
  String? username;
  String? name;
  int? ranking;
  int? reputation;
  int? solvedProblem;
  int? badges;
  String? country;
  String? company;
  String? school;

  LeetCodeModel({
    this.username,
    this.name,
    this.ranking,
    this.reputation,
    this.solvedProblem,
    this.badges,
    this.country,
    this.company,
    this.school,
  });

  LeetCodeModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['profile']?['realName'] ?? 'N/A';
    ranking = json['ranking'] ?? 0;
    reputation = json['reputation'] ?? 0;
    solvedProblem = (json['submitStats']?['acSubmissionNum'] as List?)
        ?.firstWhere((item) => item['difficulty'] == 'All', orElse: () => {'count': 0})['count'] ?? 0;
    badges = (json['badges'] as List?)?.length ?? 0;
    country = json['profile']?['countryName'] ?? 'N/A';
    company = json['profile']?['company'] ?? 'N/A';
    school = json['profile']?['school'] ?? 'N/A';
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'ranking': ranking,
      'reputation': reputation,
      'solvedProblem': solvedProblem,
      'badges': badges,
      'country': country,
      'company': company,
      'school': school,
    };
  }
}
