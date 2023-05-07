import 'package:pattern_m/src/modules/home/model/git.issue.model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/home.api.dart';
import '../model/sub_model/issue.label.dart';

typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, List<GitIssue>?>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AsyncNotifier<List<GitIssue>?> {
  List<GitIssue> gitIssue = [];
  List<IssueLabel> issueLabel = [];
  List<IssueLabel> selectedIssueLabel = [];

  int page = 0;
  bool isLoading = false;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  FutureOr<List<GitIssue>?> build() async {
    gitIssue = [...?await getIssues(page)];
    return gitIssue;
  }

  issueList() {
    issueLabel = gitIssue.expand((element) => element.labels).toSet().toList();
    return issueLabel;
  }

  void loadMore() async {
    page++;
    isLoading = true;
    gitIssue = [...gitIssue, ...?await getIssues(page)];
    isLoading = false;
  }

  Future<void> refresh() async {
    page = 0;
    final issues = await getIssues(page);
    if (issues != null) gitIssue = issues;
    issueList();
    refreshController.refreshCompleted();
    ref.notifyListeners();
  }
}


// 1 ta class create  => AbcNotifier

// arelkta access korte hobe => abcProvider

// type => AbcProvider