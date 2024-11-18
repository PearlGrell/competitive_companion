class CodeChefModel {
  String? name;
  String? username;
  String? rating;
  String? maxRating;
  String? globalRank;
  String? countryRank;

  CodeChefModel(
      {this.name,
        this.username,
        this.rating,
        this.maxRating,
        this.globalRank,
        this.countryRank});

  CodeChefModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    rating = json['rating'];
    maxRating = json['maxRating'];
    globalRank = json['globalRank'];
    countryRank = json['countryRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['rating'] = rating;
    data['maxRating'] = maxRating;
    data['globalRank'] = globalRank;
    data['countryRank'] = countryRank;
    return data;
  }
}
