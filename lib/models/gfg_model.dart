class GeeksForGeeksModel {
  String? name;
  String? profilePhoto;
  String? instituteRank;
  String? currentStreak;
  String? maxStreak;
  String? institution;
  String? codingScore;
  String? totalProblemsSolved;
  SolvedStats? solvedStats;

  GeeksForGeeksModel(
      {this.name,
        this.profilePhoto,
        this.instituteRank,
        this.currentStreak,
        this.maxStreak,
        this.institution,
        this.codingScore,
        this.totalProblemsSolved,
        this.solvedStats});

  GeeksForGeeksModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePhoto = json['profilePhoto'];
    instituteRank = json['instituteRank'];
    currentStreak = json['currentStreak'];
    maxStreak = json['maxStreak'];
    institution = json['institution'];
    codingScore = json['codingScore'];
    totalProblemsSolved = json['totalProblemsSolved'];
    solvedStats = json['solvedStats'] != null
        ? SolvedStats.fromJson(json['solvedStats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profilePhoto'] = profilePhoto;
    data['instituteRank'] = instituteRank;
    data['currentStreak'] = currentStreak;
    data['maxStreak'] = maxStreak;
    data['institution'] = institution;
    data['codingScore'] = codingScore;
    data['totalProblemsSolved'] = totalProblemsSolved;
    if (solvedStats != null) {
      data['solvedStats'] = solvedStats!.toJson();
    }
    return data;
  }
}

class SolvedStats {
  int? school;
  int? easy;
  int? medium;
  int? hard;

  SolvedStats({this.school, this.easy, this.medium, this.hard});

  SolvedStats.fromJson(Map<String, dynamic> json) {
    school = json['school'];
    easy = json['easy'];
    medium = json['medium'];
    hard = json['hard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['school'] = school;
    data['easy'] = easy;
    data['medium'] = medium;
    data['hard'] = hard;
    return data;
  }
}