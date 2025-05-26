// class UsersModel {
//   String? nameUser;
//   String? email;
//   String? password;
//   String? phoneNumber;

//   UsersModel({this.nameUser, this.email, this.password, this.phoneNumber});

//   UsersModel.fromJson(Map<String, dynamic> json) {
//     nameUser = json['name_user'];
//     email = json['email'];
//     password = json['password'];
//     phoneNumber = json['phone_number'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name_user'] = this.nameUser;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['phone_number'] = this.phoneNumber;
//     return data;
//   }
// }

class UsersModel {
  final int id;
  final String nameUser;
  final String phoneNumber;
  final String email;

  UsersModel({
    required this.id,
    required this.nameUser,
    required this.phoneNumber,
    required this.email,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      nameUser: json['name_user'],
      phoneNumber: json['phone_number'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_user': nameUser,
      'phone_number': phoneNumber,
      'email': email,
    };
  }
}
