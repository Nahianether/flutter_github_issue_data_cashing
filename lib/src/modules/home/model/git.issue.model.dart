import 'dart:convert';

import 'sub_model/issue.label.dart';
import 'sub_model/user.model.dart';

List<GitIssue> gitIssueFromJson(String str) =>
    List<GitIssue>.from(json.decode(str).map((x) => GitIssue.fromRawJson(x)));

class GitIssue {
  final int id;
  final User user;
  final String body;
  final String title;
  final DateTime createdAt;
  final List<IssueLabel> labels;

  GitIssue({
    required this.id,
    required this.user,
    required this.body,
    required this.title,
    required this.labels,
    required this.createdAt,
  });

  factory GitIssue.fromRawJson(Map<String, dynamic> json) => GitIssue(
        id: json[_Json.id] as int,
        body: json[_Json.body] as String,
        title: json[_Json.title] as String,
        createdAt: DateTime.parse(json[_Json.createdAt] as String),
        user: User.fromRawJson(json[_Json.user] as Map<String, dynamic>),
        labels: (json[_Json.labels] as List<dynamic>)
            .map((e) => IssueLabel.fromRawJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class _Json {
  static const String id = 'id';
  static const String user = 'user';
  static const String body = 'body';
  static const String title = 'title';
  static const String labels = 'labels';
  static const String createdAt = 'created_at';
}
