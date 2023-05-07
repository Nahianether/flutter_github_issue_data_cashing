import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pattern_m/src/extensions/extensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../router/provider/route.provider.dart';
import '../../setting/view/setting.view.dart';
import '../provider/home.provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async => await fadePush(context, const SettingView()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Body(),
    );
  }
}

class Body extends ConsumerWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeProvider.notifier);
    return SmartRefresher(
      controller: ref.watch(homeProvider.notifier).refreshController,
      enablePullUp: true,
      onRefresh: ref.watch(homeProvider.notifier).refresh,
      onLoading: ref.watch(homeProvider.notifier).loadMore,
      child: SizedBox(
        height: context.height - 100,
        width: context.width,
        child: ref.watch(homeProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text(error.toString())),
              data: (_) => ListView.builder(
                itemCount: notifier.gitIssue.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notifier.gitIssue[index].title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notifier.gitIssue[index].user.login),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                notifier.gitIssue[index].labels.length,
                                (index1) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Chip(
                                    side: BorderSide(
                                      color: Color(
                                        int.parse(
                                          '0xFF${notifier.gitIssue[index].labels[index1].color}',
                                        ),
                                      ),
                                      width: 1.0,
                                    ),
                                    backgroundColor: Colors.white,
                                    label: Text(
                                      notifier
                                          .gitIssue[index].labels[index1].name,
                                      style: TextStyle(
                                        color: Color(
                                          int.parse(
                                            '0xFF${notifier.gitIssue[index].labels[index1].color}',
                                          ),
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      ),
    );
  }
}
