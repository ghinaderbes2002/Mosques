class RatingModel {
  final int? ratingId;
  final int ratingValue;
  final String? comment;
  final int userId;
  final int mosqueId;

  RatingModel({
    this.ratingId,
    required this.ratingValue,
    required this.comment,
    required this.userId,
    required this.mosqueId,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      ratingId: json['rating_id'],
      ratingValue: json['rating_value'],
      comment: json['comment'],
      userId: json['user_id'],
      mosqueId: json['mosque_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating_id': ratingId,
      'rating_value': ratingValue,
      'comment': comment,
      'user_id': userId,
      'mosque_id': mosqueId,
    };
  }
}
