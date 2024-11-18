class LeetCodeModel {
  String? username;
  String? realName;
  String? country;
  String? company;
  String? school;
  int? solvedProblems;

  LeetCodeModel(
      {this.username,
        this.realName,
        this.country,
        this.company,
        this.school,
        this.solvedProblems});

  LeetCodeModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    realName = json['realName'];
    country = json['country'];
    company = json['company'];
    school = json['school'];
    solvedProblems = json['solvedProblems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['realName'] = realName;
    data['country'] = country;
    data['company'] = company;
    data['school'] = school;
    data['solvedProblems'] = solvedProblems;
    return data;
  }
}