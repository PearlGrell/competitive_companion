class CodeforcesModel {
  String? name;
  int? rating;
  String? handle;
  int? contribution;
  String? rank;
  int? maxRating;
  String? maxRank;

  CodeforcesModel({
    this.name,
    this.rating,
    this.handle,
    this.contribution,
    this.rank,
    this.maxRating,
    this.maxRank,
  });

  CodeforcesModel.fromJson(Map<String, dynamic> json) {
    String firstName = json['firstName'] ?? 'N/A';
    String lastName = json['lastName'] ?? 'N/A';
    if(firstName == 'N/A' && lastName == 'N/A') {
      name = 'N/A';
    }
    else {
      name='$firstName $lastName';
    }
    rating = json['rating'];
    handle = json['handle'];
    contribution = json['contribution'];
    rank = json['rank'];
    maxRating = json['maxRating'];
    maxRank = json['maxRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<String> nameParts = name?.split(" ") ?? ['N/A', 'N/A'];
    data['firstName'] = nameParts[0];
    data['lastName'] = nameParts.length > 1 ? nameParts[1] : 'N/A';
    data['rating'] = rating;
    data['handle'] = handle;
    data['contribution'] = contribution;
    data['rank'] = rank;
    data['maxRating'] = maxRating;
    data['maxRank'] = maxRank;
    return data;
  }
}
