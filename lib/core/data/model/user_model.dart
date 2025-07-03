class UsersModel {
  final int id; // هنا اسم الحقل id
  final String nameUser; // هنا اسم الحقل nameUser
  final String? phoneNumber;
  final String? email;

  UsersModel({
    required this.id,
    required this.nameUser,
    this.phoneNumber,
    this.email,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['user_id'] ?? 0, // هنا ربطت 'user_id' مع id
      nameUser: json['name_user'] ?? '',
      phoneNumber: json['phone_number'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id, // هنا ربطت id مع 'user_id'
      'name_user': nameUser,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
    };
  }
}
