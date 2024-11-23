class CodeforcesModel {
  String? name;
  int? rating;
  String? handle;
  int? contribution;
  String? rank;
  int? maxRating;
  String? maxRank;

  CodeforcesModel(
      {this.name,
        this.rating,
        this.handle,
        this.contribution,
        this.rank,
        this.maxRating,
        this.maxRank});

  CodeforcesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    handle = json['handle'];
    contribution = json['contribution'];
    rank = json['rank'];
    maxRating = json['maxRating'];
    maxRank = json['maxRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['rating'] = rating;
    data['handle'] = handle;
    data['contribution'] = contribution;
    data['rank'] = rank;
    data['maxRating'] = maxRating;
    data['maxRank'] = maxRank;
    return data;
  }
}

class CodeforcesContest {
  int? contestId;
  String? contestName;
  List<Standings>? standings;

  CodeforcesContest({this.contestId, this.contestName, this.standings});

  CodeforcesContest.fromJson(Map<String, dynamic> json) {
    contestId = json['contestId'];
    contestName = json['contestName'];
    if (json['standings'] != null) {
      standings = <Standings>[];
      json['standings'].forEach((v) {
        standings!.add(Standings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contestId'] = contestId;
    data['contestName'] = contestName;
    if (standings != null) {
      data['standings'] = standings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Standings {
  int? rank;
  String? handle;
  int? points;
  int? penalty;
  int? successfulHackCount;
  int? unsuccessfulHackCount;
  List<ProblemResults>? problemResults;

  Standings(
      {this.rank,
        this.handle,
        this.points,
        this.penalty,
        this.successfulHackCount,
        this.unsuccessfulHackCount,
        this.problemResults});

  Standings.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    handle = json['handle'];
    points = json['points'];
    penalty = json['penalty'];
    successfulHackCount = json['successfulHackCount'];
    unsuccessfulHackCount = json['unsuccessfulHackCount'];
    if (json['problemResults'] != null) {
      problemResults = <ProblemResults>[];
      json['problemResults'].forEach((v) {
        problemResults!.add(ProblemResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rank'] = rank;
    data['handle'] = handle;
    data['points'] = points;
    data['penalty'] = penalty;
    data['successfulHackCount'] = successfulHackCount;
    data['unsuccessfulHackCount'] = unsuccessfulHackCount;
    if (problemResults != null) {
      data['problemResults'] =
          problemResults!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProblemResults {
  int? points;
  int? rejectedAttemptCount;
  String? type;

  ProblemResults({this.points, this.rejectedAttemptCount, this.type});

  ProblemResults.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    rejectedAttemptCount = json['rejectedAttemptCount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['points'] = points;
    data['rejectedAttemptCount'] = rejectedAttemptCount;
    data['type'] = type;
    return data;
  }
}
