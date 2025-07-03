import 'package:mosques/core/data/model/user_model.dart';

class RatingModel {
  final int? ratingId;
  final int ratingValue;
  final String comment;
  final int userId;
  final int mosqueId;
  final UsersModel? user;

  RatingModel({
    this.ratingId,
    required this.ratingValue,
    required this.comment,
    required this.userId,
    required this.mosqueId,
    this.user,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      ratingId: json['rating_id'] as int?,
      ratingValue: json['rating_value'] ?? 0,
      comment: json['comment'] ?? '',
      userId: json['user_id'] ?? 0,
      mosqueId: json['mosque_id'] ?? 0,
      user: json['users'] != null ? UsersModel.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating_id': ratingId,
      'rating_value': ratingValue,
      'comment': comment,
      'user_id': userId,
      'mosque_id': mosqueId,
      'users': user?.toJson(), // هنا مفروض تضيف toJson داخل UsersModel أيضاً
    };
  }
}
