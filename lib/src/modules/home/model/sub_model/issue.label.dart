


class IssueLabel {
  final int id;
  final String name;
  final String color;

  IssueLabel({
    required this.id,
    required this.name,
    required this.color,
  });

  factory IssueLabel.fromRawJson(Map<String, dynamic> json) => IssueLabel(
        id: json[_JSON.id] as int,
        name: json[_JSON.name] as String,
        color: json[_JSON.color] as String,
      );
}

class _JSON {
  static const String id = 'id';
  static const String name = 'name';
  static const String color = 'color';
}