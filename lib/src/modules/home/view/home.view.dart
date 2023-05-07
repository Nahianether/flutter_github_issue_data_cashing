import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pattern_m/src/extensions/extensions.dart';

import '../../../localization/loalization.dart';
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
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                labelText: 'Search',
              ),
            ),
            Flexible(
              child: ref.watch(homeProvider).when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Center(child: Text(error.toString())),
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
                                // ListView.builder(
                                //     shrinkWrap: true,
                                //     itemCount:
                                //         notifier.gitIssue[index].labels.length,
                                //     scrollDirection: Axis.horizontal,
                                //     itemBuilder: (context, index2) {
                                //       return Chip(
                                //         label: Text(notifier.gitIssue[index]
                                //             .labels[index2].name),
                                //       );
                                //     }),
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
                                            notifier.gitIssue[index]
                                                .labels[index1].name,
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
          ],
        ),
      ),
    );
  }
}
