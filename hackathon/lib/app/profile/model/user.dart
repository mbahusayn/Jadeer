class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
      };
}
