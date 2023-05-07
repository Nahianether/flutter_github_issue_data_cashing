import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/git.issue.model.dart';

Future<List<GitIssue>?> getIssues([int page = 0, int perPage = 25]) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.github.com/repos/flutter/flutter/issues?per_page=$perPage&page=$page'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final body = await response.stream.bytesToString();
    final issues = gitIssueFromJson(body);
    return issues;
  } else {
    debugPrint(response.reasonPhrase);
    return null;
  }
}
