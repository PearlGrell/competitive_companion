class CodeChefModel {
  final String? name;
  final String? username;
  final String? rating;
  final String ?maxRating;
  final String? globalRank;
  final String? countryRank;

  CodeChefModel({
    this.name,
    this.username,
    this.rating,
    this.maxRating,
    this.globalRank,
    this.countryRank,
  });

  factory CodeChefModel.fromJson(Map<String, dynamic> json) {
    return CodeChefModel(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      rating: json['rating'] ?? '',
      maxRating: json['max_rating'] ?? '',
      globalRank: json['global_rank'] ?? '',
      countryRank: json['country_rank'] ?? '',
    );
  }
}
