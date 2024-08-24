class UserModel {
  final String email;
  final String name;
  final String password;
  final String id;
  final String url;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.id,
    required this.url,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json["email"],
        name: json["name"],
        password: json["password"],
        id: json["id"],
        url: json["image"]);
  }

  // Method to convert UserModel to JSON map
  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'password': password,
        'id': id,
        'image': url,
      };
}
