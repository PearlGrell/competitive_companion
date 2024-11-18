class GeeksForGeeksModel {
  String? userName;
  String? name;
  String? instituteRank;
  String? currentStreak;
  String? maxStreak;
  String? institution;
  String? codingScore;
  String? totalProblemsSolved;
  bool exists;

  Map<String, dynamic>? solvedStats;

  GeeksForGeeksModel({
    this.userName,
    this.name,
    this.instituteRank,
    this.currentStreak,
    this.maxStreak,
    this.institution,
    this.codingScore,
    this.totalProblemsSolved,
    this.solvedStats,
    this.exists = false,
  });

  GeeksForGeeksModel.fromJson(Map<String, dynamic> json, bool exist): exists = exist {
    userName = json['userName'];
    name = json['name'] ?? 'N/A';
    instituteRank = json['instituteRank'] ?? 'N/A';
    currentStreak = json['currentStreak'] ?? '00';
    maxStreak = json['maxStreak'] ?? '00';
    institution = json['institution'] ?? 'N/A';
    codingScore = json['codingScore'] ?? '0';
    totalProblemsSolved = json['totalProblemsSolved'] ?? '0';
    solvedStats = json['solvedStats'];
    exists = exist;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['name'] = name;
    data['instituteRank'] = instituteRank;
    data['currentStreak'] = currentStreak;
    data['maxStreak'] = maxStreak;
    data['institution'] = institution;
    data['codingScore'] = codingScore;
    data['totalProblemsSolved'] = totalProblemsSolved;
    data['solvedStats'] = solvedStats;
    return data;
  }
}
