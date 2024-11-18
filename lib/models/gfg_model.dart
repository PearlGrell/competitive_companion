class GeeksForGeeksModel {
  String? userName;
  String? name;
  String? profilePhoto;
  String? instituteRank;
  String? currentStreak;
  String? maxStreak;
  String? institution;
  String? codingScore;
  String? totalProblemsSolved;

  Map<String, dynamic>? solvedStats;

  GeeksForGeeksModel({
    this.userName,
    this.name,
    this.profilePhoto,
    this.instituteRank,
    this.currentStreak,
    this.maxStreak,
    this.institution,
    this.codingScore,
    this.totalProblemsSolved,
    this.solvedStats,
  });

  GeeksForGeeksModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    name = json['name'] ?? 'N/A';
    profilePhoto = json['profilePhoto'] ?? '';
    instituteRank = json['instituteRank'] ?? 'N/A';
    currentStreak = json['currentStreak'] ?? '00';
    maxStreak = json['maxStreak'] ?? '00';
    institution = json['institution'] ?? 'N/A';
    codingScore = json['codingScore'] ?? '0';
    totalProblemsSolved = json['totalProblemsSolved'] ?? '0';
    solvedStats = json['solvedStats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['name'] = name;
    data['profilePhoto'] = profilePhoto;
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
