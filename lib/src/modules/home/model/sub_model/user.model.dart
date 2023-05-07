class User {
  final int id;
  final String login;

  User({
    required this.id,
    required this.login,
  });

  factory User.fromRawJson(Map<String, dynamic> json) => User(
        id: json[_JSON.id] as int,
        login: json[_JSON.login] as String,
      );
}

class _JSON {
  static const String id = 'id';
  static const String login = 'login';
}
