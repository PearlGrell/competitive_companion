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